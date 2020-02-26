Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577D317066D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 18:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBZRqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 12:46:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40503 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgBZRqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Feb 2020 12:46:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so2052155wrj.7
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2020 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UlkKnDdC74Y3bgeE6cEbPgpR1UfcBBF9OT0zkr0EUcg=;
        b=BGEEl7rmEJYfaMnxUESPvUOgeSbE0vRSPk4AeQjFIwdfBqYXStXjR+rObFWAaQbqg1
         bdOXNcZYOR+hFebyfy7thu2k30LD1Epy2eOgsjn2SuwHoRCJF0Kr0DjH22TAgWxY41Dc
         C0PcGYnjSiPRM14Hw2u0Z+2cwUCdQyjwFvYmSiRwtnHdOIcJvaLybuk0VDxnmE+PZJnn
         4QRNIzz04bdlHohCuatcxOucvZ/Blllhhelky/i5lwYCXd4SKOspi5gFSfrWYCblUndd
         xEShQS4T63fHgE3ImaZRxkrl8P2+FnSF52tCc/zApvyPYTpmoo/A2s2FttSQYn0waYFI
         xy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UlkKnDdC74Y3bgeE6cEbPgpR1UfcBBF9OT0zkr0EUcg=;
        b=IQVm0efMLj8EMy0Z4CQLA0wjDzll0jTF4wRvAm4DQGXU6jUFFnMGTSmaG9OP5i/K+y
         48zXAOydJdGMAbUC7mO4BUaKJb+sdolHdOcXWjdvPRT8hmxfp2gFtIFM3vUHB6Q9jrnl
         Y4Tuxv+9Swf0Y06p26D4nsdfNkNWaTYTtJwBjVn+VWZ/0mciATsOZQCyxsfiRBOToAGo
         C02gxdxsFWhRv5hbeFJYw7dNmjIMUYr0bX4KVJPbxJPBmoNoIus+GToQEa/ICgwIQCBA
         0cdxkU2mu+x+tVxq1NFClbO285p99wai6x94dcr2XGG+0iQ1/MtYHbtMzr19SdJvOMxG
         uFew==
X-Gm-Message-State: APjAAAUatev5v+Vgs2Q5utpW2Vaoh4tp05FcoRKd2EzaebyROrgEd53T
        TqfuPZPxW/Dd5RhlD42AvOI+lQ==
X-Google-Smtp-Source: APXvYqznWapegakHJtPU90RjlpTQd/0Tw1lU93h5a+hpgxjq61bdBeFBGzJDvg53TH5tsUPPbp4LDg==
X-Received: by 2002:adf:fc12:: with SMTP id i18mr6690147wrr.354.1582739168790;
        Wed, 26 Feb 2020 09:46:08 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id d76sm3849939wmd.39.2020.02.26.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:46:08 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:46:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200226174640.GR3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
 <20200223131638.12130-2-andreas@kemnade.info>
 <20200226154055.GQ3494@dell>
 <20200226174914.047667d5@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226174914.047667d5@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Feb 2020, Andreas Kemnade wrote:

> On Wed, 26 Feb 2020 15:40:55 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Sun, 23 Feb 2020, Andreas Kemnade wrote:
> > 
> > > This adds a subdevice for the ADC in the RC5T619
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > depends on:
> > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> > > 
> > > Changes in v3:
> > > re-added it to the series because of
> > > "Oh, it looks like there was a conflict.  Could you collect any Acks
> > > (including mine) rebase and resend please?"  
> > 
> > Looks like there is still a conflict.  Sure, it's not a complicated
> > fix, but that's beside the point.  What tree is this set based on?
> > 
> It must be applied on top of my rc5t619 rtc series here:
> https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> 
> I expected it to make it into 5.6 and when I first sent the RTC series
>  (in October) I had no idea when I will continue with other stuff.
> 
> That is why I sent this ADC series separately, also to give the IIO
> maintainer plenty of time to review. 

If a patch-set can or should be applied on its own, you should send it
based on an upstream commit, or else things like this happen.

My advice would be to maintain topic branches, each based on an
upstream release, which you can merge together into an integration
branch for full coverage testing.

> Do you want me to resend all that pending stuff together in one series?
> I have little experience with this multi-subdevice process.

It makes more sense to rebase this set onto the latest full release
and resubmit this set on its own.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
