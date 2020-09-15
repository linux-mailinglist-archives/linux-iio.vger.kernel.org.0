Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E226AD1B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgIOTJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:09:55 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38551 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIOTGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:06:19 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so4070937ilp.5;
        Tue, 15 Sep 2020 12:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P4TRYYtHdi2NxFtRdH6btCn2LecsBeel5nAXNs5xvW4=;
        b=oHQDZetSJ86XPXbTwYJdwdsv/51jOs++jNpPHSZtDMJzLYnR9rLOV08xiuq3YKckp+
         SQM07sERLqxoi3wo7E5UyME+UAsBMCnRc5ALw3gIcJe9QUb1JwEmSBC16hP23iKZm81O
         uakP2husZTrIeNOgopbo0qlNzeFrAzoEdSeJf2ucz/DnYUtTktnNp8mBU0k6Bzg4I6LV
         Ndr2NkZXlK9x+nNu0h7hs1SWUfG8zcejQiT71+05t1CI/J2aALDKOdl3zEepcgTcX9VF
         DmW2jhC+tFikKnew3vgcjrR88PCbbYf8pfQ/qnNi9/A6e+Ef/TkhOeDaEn0XwkbPEj/y
         WOwQ==
X-Gm-Message-State: AOAM533VkS9DNo7oOrY1/cBQWh4nOo/KtZ4v/pBfxNTDuD4y4TYrxV38
        wuCe1cC1PPUXtzVfOIkc8HCuly6qndYCZR8=
X-Google-Smtp-Source: ABdhPJz5s4dyhtEaGQnCibWLHpkkFbI+Ajqw1QsH6Y2NbI/REMekGVe/67oVqhMaZDmR7GhKiE09bg==
X-Received: by 2002:a92:a04a:: with SMTP id b10mr7089664ilm.279.1600196778216;
        Tue, 15 Sep 2020 12:06:18 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u17sm9495576ilb.44.2020.09.15.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:06:17 -0700 (PDT)
Received: (nullmailer pid 2321966 invoked by uid 1000);
        Tue, 15 Sep 2020 19:06:16 -0000
Date:   Tue, 15 Sep 2020 13:06:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/20] dt-bindings:iio:adc:nuvoton,nau7802 yaml
 conversion
Message-ID: <20200915190616.GA2321912@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-8-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:33 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A simple conversion from txt file to yaml.  I added the #io-channel-cells
> property as optional to allow the channels of this ADCs to be used
> to provide services to other drivers, for example if an analog
> accelerometer is connected.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/iio/adc/nuvoton,nau7802.yaml     | 50 +++++++++++++++++++
>  .../bindings/iio/adc/nuvoton-nau7802.txt      | 18 -------
>  2 files changed, 50 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
