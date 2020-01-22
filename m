Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3104E1459C2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 17:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAVQYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 11:24:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQYP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 11:24:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so6738415otj.11;
        Wed, 22 Jan 2020 08:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBSuorVlBPJZlT0IMnm/ezCQKABZUi84K977zkiUy4Q=;
        b=ZzpKzWSrIQ9DhhPtx8RzOsg5vR2O/VcuI6z/WYy0PIr4FB228OrywE+JnV7BW370m6
         M1zCb1naZ1vZcVq2F2/9mHXMO2LEAw21b2yny254cq7dLzCpTtu02sgpZAYDuikX6LmD
         Ug1l0g+1MgPrm1UeQs5WdiHqXfK6Os1wZBRVSdlzD6dSzFYPkkJfBHjIe2hs5X75cgDs
         Ydk3Z5vpa/7FZdUTM31uW9eecikjr0ds8LT0N1BSsKcnrSzxuq7gH9rpx5f3oFmoFvlt
         Ctm5G8MtPaMfa/ETNztSW8o0k91cES5AfE9TpeuyMIDdXvorC90Z08WUkbeL8W3hDkca
         YLyQ==
X-Gm-Message-State: APjAAAVVEv+XuoZxOD9rzuoGpv33M8inGzNVW0DvDHTqrl8kR+Gux6a1
        080gyWnpFOKDBnGcONj4MA==
X-Google-Smtp-Source: APXvYqw17VzUmX0qRYVT5h/d0qjRAnAfVEstQIvab3ApXczGOHJMy7ssOSpdqRBH6QMPhi2wqFsc3Q==
X-Received: by 2002:a9d:7342:: with SMTP id l2mr7999588otk.98.1579710254147;
        Wed, 22 Jan 2020 08:24:14 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m19sm14777791otn.47.2020.01.22.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:24:13 -0800 (PST)
Received: (nullmailer pid 9959 invoked by uid 1000);
        Wed, 22 Jan 2020 16:24:12 -0000
Date:   Wed, 22 Jan 2020 10:24:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, joel@jms.id.au,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-binding: iio: add NPCM ADC reset support
Message-ID: <20200122162412.GA9924@bogus>
References: <20200119110032.124745-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119110032.124745-1-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Jan 2020 13:00:31 +0200, Tomer Maimon wrote:
> Add NPCM ADC reset binding documentation.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
