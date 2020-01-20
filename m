Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084BB14261A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 09:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgATItE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 03:49:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43870 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATItE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 03:49:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so28570331wre.10
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2020 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lxugTqd5gx4s0FvVRSPm+5otlIxwWK1Pj17RAfoBOS4=;
        b=JNgc40bl0G/QHlFAX7ZtfW5yBwLXYxJ/vsPFyciEnFpiFzYjhVOBK0Tu0Nw56qLXrF
         s9Fy8zsOy6Tk78ielbCEgz0i+XiH3sv5x69H6Yy0WXdizvGbGg1caE0RdxxflLNNabkD
         rcmnp8bHMTMDM4r4ubum4hpIZzTrNmEfMigiMNeeeXcTkVmFlPc6SqPPsGIA0u5bG6XK
         qo5AU2ltXN/XPCkMpzB4ySRrWXSwT6Aj/7j9CqW8ZBKHHy6RJxTPZQqok/axcdXjHXxb
         w6TByw+GQq9rskEZyG1JQLaI7zi+kAu9BGCtaMHu7IXwR+jleeTCC6xVJupnigWoXR3T
         knRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lxugTqd5gx4s0FvVRSPm+5otlIxwWK1Pj17RAfoBOS4=;
        b=nIjNWbi8ckd1RXBCozCcSV9N5FGopxRwGawQRwOWn2Voy8d7xvB9upnPjeR34oWHnL
         fUWpjC8fB8YSS0WiVesLpQ7w5Z4v9htnk8eT+lH/LudOVqbMZWNK9R+Enn+0PKw8AD83
         Xxoz3yUNg7Iib1HW6xmoshbYkHzvhY4AsE6gg7SHAPH64NpMxcWNy/yzWMMvO494WWoC
         1SrefoVCI/e81qD/EW7QGoqhemxoZ7zIjXspdqpOOp/+IaBXGL+xKCJU9YSUxPdUXNGX
         TL2txK/euDTYKB9YmZc6XRSoE1w1OBFFq4Py7EJdrglrP8GyEP3CvSQ4ZWBS1RW0qZNk
         yAZg==
X-Gm-Message-State: APjAAAVEPG+vdXEoTijYlGG8jkJkblFWxid1G4JSMGCnBFlWQ2EaI0j0
        vj9P2E4aijGcSq9AHlylk+YCHw==
X-Google-Smtp-Source: APXvYqx2RJrI4RQGXHHZQOVf6Uwexmpsyu0RtvPRcO9+u34yaNc221koOFIDxVYnabwCKzmfcBesWA==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr17901121wrs.276.1579510141773;
        Mon, 20 Jan 2020 00:49:01 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id y6sm45296009wrl.17.2020.01.20.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:49:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:49:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/5] mfd: rn5t618: mark ADC control register volatile
Message-ID: <20200120084917.GY15507@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
 <20200117215926.15194-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117215926.15194-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jan 2020, Andreas Kemnade wrote:

> There is a bit which gets cleared after conversion.
> 
> Fixes: 9bb9e29c78f8 ("mfd: Add Ricoh RN5T618 PMIC core driver")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
