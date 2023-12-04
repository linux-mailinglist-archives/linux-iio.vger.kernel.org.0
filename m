Return-Path: <linux-iio+bounces-593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB80803900
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B0E2811B6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338E2C86A;
	Mon,  4 Dec 2023 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVZpLFeq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5551799E;
	Mon,  4 Dec 2023 15:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0F8C433C8;
	Mon,  4 Dec 2023 15:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704346;
	bh=G3X+vmde+cr11/lAMlOMQHfGd+SQv6ekjh9J8L55ZRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVZpLFeqSXJ+oqgWCvDcEICrbiSZaOdS+ZZIIYPJPyEynaYyEaqQBTFia3KGSAvQM
	 LeA522/+DiQBb67g6AqvgJxMZBGqLnwdqey1BuqYfanwfE7HIyAFqZ4VtZaedSgHW7
	 wDysUfO7qMGadjo3YCWhj26TQx25+SnUbP1EGwAfc/7m8xr7G20oA8+EoubfK9eqAw
	 AkduxD8F9Tkm1jEW9+WUTo5mRhBMImuICHbMqFzYahEJ4CBdo9v7p9ac0dBvnFRzDF
	 3GA01P9uc1n7CknA2RYxzjDIB7thFxTfDFeKSXPkvhM5IZwJ7zNO8xBfNZzTautCgc
	 ZPzhPGWeyeFqw==
Date: Mon, 4 Dec 2023 15:38:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 03/12] iio: add the IIO backend framework
Message-ID: <20231204153855.71c9926f@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:20:16 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> This is a Framework to handle complex IIO aggregate devices.
> 
> The typical architecture is to have one device as the frontend device which
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).

As this is first place backend / frontend terminology used (I think), make
sure to give an example so people understand what sorts of IP / devices thes
might be.

> 
> The basic framework interface is pretty simple:
>  - Backends should register themselves with @devm_iio_backend_register()
>  - Frontend devices should get backends with @devm_iio_backend_get()
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Looks good to me in general.  I'll need to have a really close read though
before we merge this as there may be sticky corners! (hopefully not)


...

> +static LIST_HEAD(iio_back_list);
> +static DEFINE_MUTEX(iio_back_lock);
> +
> +/*
> + * Helper macros to properly call backend ops. The main point for these macros
> + * is to properly lock the backend mutex on every call plus checking if the
> + * backend device is still around (by looking at the *ops pointer).
If just checking if it is around rather thank looking for a bug, then
I'd suggest a lighter choice than WARN_ON_x 

Btw, there were some interesting discussions on lifetimes and consumer / provider
models at plumbers. I think https://www.youtube.com/watch?v=bHaMMnIH6AM will be
the video.   Suggested the approach of not refcounting but instead allowing for
a deliberate removal of access similar to your check on ops here (and the one
we do in core IIO for similar purposes).  Sounded interesting but I've not
explored what it would really mean to switch to that model yet.

> + */
> +#define iio_backend_op_call(back, op, args...) ({ \
> +	struct iio_backend *__back = back; \
> +	int __ret; \
> +			\
> +	guard(mutex)(&__back->lock); \
> +	if (WARN_ON_ONCE(!__back->ops)) \
> +		__ret = -ENODEV; \
> +	else if (!__back->ops->op) \
> +		__ret = -EOPNOTSUPP; \
> +	else \
> +		__ret = __back->ops->op(__back, ##args); \
> +	\
> +	__ret; \
> +})


