Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73801E7A4E
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2KQU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 06:16:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45483 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 06:16:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id z18so1881456lji.12;
        Fri, 29 May 2020 03:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qb23YrFge2bev6B+pdY5MYpRbBAt1YLbxMOSUywPdHk=;
        b=cZaH0DKeLwkKayN1g+x2VJNhADXnu4nL0vSdS/b+fM2kg+16H4sXwqx6iK+z8ZyLeF
         uPY2l26f1BPnMQft2ohw7um4HIFJRpj6OL3aQkyb1cFItrFXrXmSCdT5H7jC+TlyQwDm
         ZjfpqLk5ryiZaCaBSoSaMAVOEfWBRMg2yP4zNFDPNLx1iDNny2k1ZgNw3mx02BIpRWVV
         XKCXBojmkFewoirKEDwupB9EKXMiPWwfaXZg7aJUIaIrifa5ohS7rFYYTkMXQGo2J/z0
         0CVzTu3Gp9kz3GXLKhI4Dir9VBMXpCVOy+TnoQHfJ7wUQFB5TvozI5lpt2meE0lEoBln
         9m3A==
X-Gm-Message-State: AOAM531MzDINtCgDtROORRtIEWc36Cnsd2TOl9Tl3yF03DFtuIwvi6f6
        51KH4BmEL9ijvv2nF/RLdPs=
X-Google-Smtp-Source: ABdhPJyb49lJcndlDqUtkrSajYOpqC0lpLBM00Du0tW1RABChW4sreguvSnQJV4+HR28+sDilaHYIw==
X-Received: by 2002:a05:651c:39b:: with SMTP id e27mr3886282ljp.253.1590747373144;
        Fri, 29 May 2020 03:16:13 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h26sm2236339lja.0.2020.05.29.03.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:16:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jec3c-0004TR-D6; Fri, 29 May 2020 12:16:08 +0200
Date:   Fri, 29 May 2020 12:16:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        vilhelm.gray@gmail.com, syednwaris@gmail.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jic23@kernel.org, dan@dlrobertson.com,
        jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linus.walleij@linaro.org, wens@csie.org, hdegoede@redhat.com,
        rjui@broadcom.com, sbranden@broadcom.com, peda@axentia.se,
        kgene@kernel.org, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, ak@it-klinger.de, paul@crapouillou.net,
        milo.kim@ti.com, vz@mleia.com, slemieux.tyco@gmail.com,
        khilman@baylibre.com, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, heiko@sntech.de, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, mripard@kernel.org,
        tduszyns@gmail.com, rmfrfs@gmail.com, lorenzo.bianconi83@gmail.com,
        ktsai@capellamicro.com, songqiang1304521@gmail.com,
        tomislav.denis@avl.com, eajames@linux.ibm.com,
        dmitry.torokhov@gmail.com, coproscefalo@gmail.com
Subject: Re: [PATCH 4/5] iio: light: lm3533-als: remove explicit parent
 assignment
Message-ID: <20200529101608.GC19480@localhost>
References: <20200522082208.383631-1-alexandru.ardelean@analog.com>
 <20200522082208.383631-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522082208.383631-4-alexandru.ardelean@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 11:22:07AM +0300, Alexandru Ardelean wrote:
> This assignment is the more peculiar of the bunch as it assigns the parent
> of the platform-device's device (i.e. pdev->dev.parent) as the IIO device's
> parent.
>
> It's unclear whether this is intentional or not.
> Hence it is in it's own patch.

Yeah, we have a few mfd drivers whose child drivers registers their
class devices directly under the parent mfd device rather than the
corresponding child platform device.

Since it's done consistently I think you need to update them all if you
really want to change this. 

And it may not be worth it since at least in theory someone could now be
relying on this topology.

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/light/lm3533-als.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index bc196c212881..0f380ec8d30c 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -852,7 +852,6 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  	indio_dev->channels = lm3533_als_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
>  	indio_dev->name = dev_name(&pdev->dev);
> -	indio_dev->dev.parent = pdev->dev.parent;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	als = iio_priv(indio_dev);

Johan
