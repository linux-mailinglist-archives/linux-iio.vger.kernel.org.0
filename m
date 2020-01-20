Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09A914261C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 09:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgATItV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 03:49:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATItU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 03:49:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so13557684wmb.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2020 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjO9Eev+SU5Q9NPoX47dhlIyYm65ZrIzTpmYSXcC0fU=;
        b=upXzz8qeD/5BtJaGzLdwuEqBKz7Y4Y95ZLbt4pmDEhvAN4VLtUl9KSf6TyxkeN3fRV
         ypojrslYQxBfDcwhLSlJacyHxEoW2v4EonxT6YAt3v0FxmiPF3Jfw2Ea0CmO7UBuvz3g
         3BTGbfIPuoZm8iMuLLZYRaz8MBTSE3Y9n4BAQyD0wDRaZsqp0NWfFbmDEjnJSpuwwtoZ
         mNFH+UXTtF87MPsVXVYMzLE3nNICfSpl+n02Lwan1WcjSHYk0ap8iJVjFyPBKSCzbMdD
         IFLWzOXNf8nRRJT/Vx7a7OgqrXnMoHUmaOC78NMfJzWFdDNC5cEI6Oz0jLu3cdxL9YDd
         hebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjO9Eev+SU5Q9NPoX47dhlIyYm65ZrIzTpmYSXcC0fU=;
        b=ZcYjs+XpPP5KD/vJpytucr+KzorduCIf6cPAazT5ezaltVnnhkar/Z3AvbpppxucGR
         EifXI36PuK1H3M3kkmF9eloXPW/loYj/GnDFEKZessXR0mlTOGyhRsVlULVatdoucLCl
         PeTny5vcc67MCPHntIXOpqZvyV4G/j5EyJd8ZXG4MIzrkp3yvdgse+vBdHjyngCNc3RJ
         +Szd62NV4Z10QuJjLymlN0MCTpKP+KrK4b59HD/ytazY70IgVoWoHJ0ot9CjCBlunozy
         tXlyyzvzpB6gaKjIr4k+/4IMQ88aoRLwuLwqCB28lxj6PNbH/BApBC1KA6fM6uo4o6l5
         FBwg==
X-Gm-Message-State: APjAAAW8ORK2e75azMQ1/dnXUTTj8y4jLije9csUDRfSiUevfYeB+yH7
        9ujpzlGjkcz264LgDZbetzARsg==
X-Google-Smtp-Source: APXvYqx0cpFv+M2+CJytRSA34riJUQ4p8jfdKQZ24wK7qihHsiYbl5xYfHDu7dN4FSwJ3ErNm2cVKQ==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr17160695wmm.157.1579510158564;
        Mon, 20 Jan 2020 00:49:18 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id 60sm47747417wrn.86.2020.01.20.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:49:18 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:49:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/5] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200120084934.GZ15507@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
 <20200117215926.15194-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117215926.15194-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jan 2020, Andreas Kemnade wrote:

> This adds a subdevice for the ADC in the RC5T619.
> 
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
