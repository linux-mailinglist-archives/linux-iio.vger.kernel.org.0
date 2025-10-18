Return-Path: <linux-iio+bounces-25242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF83BED4F9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA16189FB08
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F0257831;
	Sat, 18 Oct 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1DYc4ug"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643624DFF3;
	Sat, 18 Oct 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808154; cv=none; b=Pja6cfHjRzB6Kd6+Kn9ZJBQgwspksGgtanL0wDIeohwDSnj0cQCwuOAAjkqVz6cWGo9znI7AwIsgW0GCoptKnc1fiZY5WAmLus4a6h2Bhc2b6QEHj8umffljOE/Kr03zakHJRldi9ZBgC15buREVL8D9WIbHzC3RVq25P6kXWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808154; c=relaxed/simple;
	bh=0X/42Gp2HgeAFua8srEK2Eijhg02FpFJyGZaLhNq6Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1SwOvT1mXobJS5/RZGTiLB2+b7l8vMQVUntR66EKpko6SHUCIXGh7GZqj4CLQiVcV5n43HdsOBuO3jb4D2lIHQmG3+LGkqoSRwcFqO+kRoupnCuPKz3rC5qVjqQ7PE4Qx1Dv+Jrsb+NWZt2BFxXZcjWQQjJOwfWmUOfdcat74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1DYc4ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDAC4CEF8;
	Sat, 18 Oct 2025 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808153;
	bh=0X/42Gp2HgeAFua8srEK2Eijhg02FpFJyGZaLhNq6Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1DYc4ugf0N7q+8dmTH68sumrSdcoOP9ImoenjHckRFJ9nh7xkzBkmDI+YX9vNpQI
	 gjn5w146IT6CiAcI+TqaJB7K++4Unj+ukuwNYYrdpspnX1vcoQRZCPmX4ty3KmsgCy
	 Xdy+3zc6xr/0EAwD1KKqWpkGBucLsMcoR202YsMIS/netR7+wrneYWYoK2eCknLISH
	 /le12oGbAXNu+OEwJ0d1obkLQo1O6PjtXPYSsvXHz6RG+NUqdiFoK5KzbIxJUpvnso
	 8hhoBY2v5humaTOrmOxoH/wQ6JRzmsJaoUdltHyYaly0/Kl85nJt/Ohrp9DLUiKlWw
	 O7CjBqQrr9QGw==
Date: Sat, 18 Oct 2025 18:22:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: accel: bma220: add low-g event detection
Message-ID: <20251018182226.28335afb@jic23-huawei>
In-Reply-To: <20251014-bma220_events-v1-4-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-4-153424d7ea08@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> @@ -790,6 +884,13 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
>  		return IRQ_HANDLED;
>  	}
>  
> +	if (FIELD_GET(BMA220_IF_LOW, bma220_reg_if1))
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
I only noticed this when looking at next patch.  
Would be unusual to have reporting on 'any' acceleration dropping below
a threshold. Tends to be all drop (which is free fall detection).

I checked the datasheet quickly and looks like this should be
IIO_MOD_X_AND_Y_AND_Z  which is what we normally see for an inactivity / freefall
threshold detector.

> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +			       timestamp);
>  	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
>  
>  		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)
> 


