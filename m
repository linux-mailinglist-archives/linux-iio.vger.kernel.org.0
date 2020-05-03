Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CCC1C2CA3
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgECNF6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 09:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgECNF6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 09:05:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765892073E;
        Sun,  3 May 2020 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588511158;
        bh=g/KpiyBdHIGtCyxIHLZ2FLL0wKiuJWDBdXJg+ibzx3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A8nlAR0vGepTUJ9VOLKP4r7SrHpnVfuIxCyC68n64Lba5mNZ/BhjfsHckF3Yaurvb
         shGrDYlCohh9S3T5Ynfho5Ec3Es7fsfrHiMA4KBBttZUo5yQmeMhMsy6OcitGSxG6/
         EkE+ceu8WsRkn//4og72ELzyXU49Khr9L/GQV1rA=
Date:   Sun, 3 May 2020 14:05:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        tglx@linutronix.de, allison@lohutok.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bmp280: fix compensation of humidity
Message-ID: <20200503140553.2152709b@archlinux>
In-Reply-To: <20200429184852.GA17547@arbad>
References: <20200429184852.GA17547@arbad>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Apr 2020 20:48:54 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Output of humidity compensation is limited to the range between 0 and
> 100 percent. Add this to the compensation formula as described in the
> datasheet chapter 4.2.3.

More details needed...

1. Fixes tag
2. What is the result of this not being clamped?  What happens if I set
a value outside that range?
> 
> Change to v1:
> Thanks to Tomasz for suggesting the easier to use function clamp_val()
> which is now used.

Change log belongs below the ---
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

> ---

Here for changelog.

>  drivers/iio/pressure/bmp280-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 29c209cc1108..297ee2205bf6 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -271,6 +271,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>  		+ (s32)2097152) * calib->H2 + 8192) >> 14);
>  	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
>  
> +	var = clamp_val(var, 0, 419430400);
> +
>  	return var >> 12;
>  };
>  

