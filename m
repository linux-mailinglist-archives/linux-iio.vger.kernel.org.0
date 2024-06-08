Return-Path: <linux-iio+bounces-6063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB29012C7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFEE11F21CE4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923617A938;
	Sat,  8 Jun 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4UzUX1G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A4158A1F;
	Sat,  8 Jun 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864651; cv=none; b=M3ZUGOwE69beAQssPf8j7CyMjgr978kiNjMtc6T5vUB+m2bboZRkkpYC6CP8W3/hYicm3kHXPmCUk38HRdrp6OB6EkIgiiVDnxJ7Ui1DMQToSgrxje75nsJA+Gtb2eraZoHnxsLj1o7Xl8/O6rP/I7LDSzGXUbxltEz7wwY3T50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864651; c=relaxed/simple;
	bh=C4dJL6tWMsSdjkwlWkQP/rZTrYE4n+NI6UcHqmFk5vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiJcPaG5LiLa5KTfpq+jj+jjUJSs33OX8DxVnhswbdnJZjoLgg/At7Mh2b4REUHusagIUyBFy1qLKN7TGue3dL42Dg9rXk6YSzlwKanEpLe0Py1DbUV7fSL4y8RrUGI3oRdlbCR7TL/4ndZWHc8OvuBiZlILDwL6wVSwEdb0+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4UzUX1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E4C2BD11;
	Sat,  8 Jun 2024 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717864650;
	bh=C4dJL6tWMsSdjkwlWkQP/rZTrYE4n+NI6UcHqmFk5vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4UzUX1GeddxVVNH9KtIauujRInuJ5YJVLwg7nH5wm5qw5cXuH9gIo7cMsol+qteX
	 lWFWqw7cGINYtcEzwujah1bwV/2TQE/Bl+UJiyKCI2bRjAzry9+vtlQEdZQ3Hcctnr
	 D3VqA+wxeR/jOVYXVnugqIbe51fV9QM1c38y9dMAibLwjr8IiF8PbzXqNguRqDixod
	 OAKl1QgAUaa+bgCYPGBpiOjSnXiidBqQetEBSdQ8GZEMF6F4K8ks2WgE1PazmW7q0s
	 aHycLcI63ztPELgma+totH95DnHGpJvsLQ/aAVllCPcbpuwzkR86O8v0dATHK61YIo
	 PJLECZrqB6gjQ==
Date: Sat, 8 Jun 2024 17:37:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 0/9] Add support for AD411x
Message-ID: <20240608173720.29ee4aee@jic23-huawei>
In-Reply-To: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Jun 2024 17:53:06 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> This patch series adds support for the Analog Devices AD4111, AD4112,
>  AD4114, AD4115, AD4116 within the existing AD7173 driver.

Looks good to me.  However given you had lots of good review and
it was a Friday afternoon posting, I'm not going to pick it up until
Nuno and David have had a day or two to take a look if they want to
(and hopefully add a few more tags! :)

If I seem to have lost it (rarely happens now I use patchwork to track
things) feel free to give me a poke.

Thanks,

Jonathan

