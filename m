Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601E11348BB
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 18:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgAHQ7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 11:59:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43065 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgAHQ7z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 11:59:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so4218548oth.10
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2020 08:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2GY+NVVosTDVmvibNwMNQRy5RHqvmx65T16ZeJgxvo=;
        b=mMNTpsv1giSFnt3fT8HWKFyr8K164CFDPmC380rHwIZuG/WQWLHLylh+stvYwRUkLk
         QQriLh6sG0EhEwRcwDy4a7sztSPfFofHmeYZevAicmtHRXe7pMdErrAybaZmYeF9yTpH
         14ymsGfXHB8ORm2MeRtRyDJP+2VWppv7L/oEAvQOcTJp354puRLjZkHsJtiiYMzatlrH
         8lF6y4bR7F+t+pbf/u4z5r4acKOVXdrXIUXZ02ZB7FarPHQE9XEKA1In/kVZtkyw5nlz
         tf/UkV+QSG0W5fEio/iyB1d6CKJLbZCRnMXo6dqXaJt+scQ+ZoFBUpMOeyuNZIiqjbCc
         FFmg==
X-Gm-Message-State: APjAAAVLvuNkqnrPOToCsuUqc09Del3s/qtkZPOw/RdEVumQURNhC+p1
        CVAsqTM8eoyvVUYAZcJXAL43rCk=
X-Google-Smtp-Source: APXvYqxpFCYPRDtT/ijyb/WA4lrY4L64E9xqfY0g0muJExXxtRtqnVTy0ytu/sWr7z4lpLpxUrj4+w==
X-Received: by 2002:a05:6830:12ce:: with SMTP id a14mr4745166otq.366.1578502793926;
        Wed, 08 Jan 2020 08:59:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm1279539otl.20.2020.01.08.08.59.51
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:59:52 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:59:51 -0600
Date:   Wed, 8 Jan 2020 10:59:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 2/5] dt-bindings: iio/adc: Add touchscreen idx for JZ47xx
 SoC ADC
Message-ID: <20200108165951.GA10221@bogus>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
 <20200105001639.142061-2-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105001639.142061-2-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Jan 2020 01:16:36 +0100, Artur Rojek wrote:
> Introduce support for touchscreen channels found in JZ47xx SoCs.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
