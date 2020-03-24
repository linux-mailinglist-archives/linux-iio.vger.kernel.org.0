Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9242D190B94
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 11:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCXK5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 06:57:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45176 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgCXK5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 06:57:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so16141054wrw.12
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rxfBoUcTAjy/KXQNUn7YUvrT2t4HIupwqUhZ33S66ss=;
        b=c1xTKH3BAJuomeNyz2i+suC7oboh1pmfXLPPnrnJtADS55zxZadAuhFVqWZpQflV4E
         WACXYT7z9kMKrZBJ9a3O20E2Q8OYBg9NX2uWhKaXIdiqKRUFmzpSQum6gsv5bWN2TLai
         8Blo1IYYk0myZ+R16jwLesrB2gmLQA3KEsK75uXPhFgGSsg4Xx8WUHm24wbmetV3EGMq
         kN8UbbcflEF6GQ3GoiZ65hJugQur6GrLDD9bYIljFPFMJrq21t2mFJ50X1EoWwLs8zlx
         yUtePUy9qDaN70PuJdDARuGl3K04koFAvgEkDaYKmCXUnxmMDyNTZUmkVPPH044AcQgT
         7sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rxfBoUcTAjy/KXQNUn7YUvrT2t4HIupwqUhZ33S66ss=;
        b=jxCN9lnV9tV9MMlB6UMG8c70FyVdUPwh67zRrGoU4Dq7C5bS7tNWKUg/XCP2vUevmJ
         VzVK7OktW9uUHt0tnJd3RO/mBhiU49XgvNXd8yeMzK8zBIfKX4Fjv9kLE8qlrn6P/Od0
         ZU0RDTry8mpwXWiHzjf1TfKpxMnaE/ZnL1ShWsgO8cG5B/ZlWzhB9BVjICLz3xdarxQK
         HLleYDOv7qi7olRR7lZNRAR+AdIQwNEaS7GLFMj0fO0SqO2C5T9IU4kLp+aYrHwc1GRZ
         wXHwsPhh/96HNRIsX1us7mtRKWKM7EJ5V5a9I6GMSJVFkwP9FVe22zAkeHANbkAh4YUl
         R17w==
X-Gm-Message-State: ANhLgQ10gmqDEkiB7j+x1Pf4fO8HH4e1p2tYr8VBFhlZmIpzQUBX79rP
        myVWkY4++Y/SuaSZ7iyhI/AcMw==
X-Google-Smtp-Source: ADFU+vu/Xqcc5SljHMAFXyLi9BXIlptXWFB94z0f4tJWF2QaBlwACgFlkmLPeyXxq4y2mK7N7ncepA==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr35424592wre.412.1585047431070;
        Tue, 24 Mar 2020 03:57:11 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id h132sm2862295wmf.18.2020.03.24.03.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:57:10 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:57:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v7 4/7] mfd: rn5t618: add more subdevices
Message-ID: <20200324105759.GI5477@dell>
References: <20200320081105.12026-1-andreas@kemnade.info>
 <20200320081105.12026-5-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320081105.12026-5-andreas@kemnade.info>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Mar 2020, Andreas Kemnade wrote:

> Since the RC5T619 has a RTC, use a separate subdevice list for that.
> The ADC should be the same as in the RN5T618, according to drivers
> in the wild, but since it is not tested, the ADC is only added for
> the RC5T619.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v6:
> - squashed with patch from former ADC patchset
> 
> Changes in v3:
> - alignment cleanup
>  drivers/mfd/rn5t618.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
