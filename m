Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B395632FCF7
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFUA0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 15:00:26 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46523 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCFT77 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 14:59:59 -0500
Received: by mail-pg1-f181.google.com with SMTP id h4so3709432pgf.13;
        Sat, 06 Mar 2021 11:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erxLaPpHTstlUNHepYANnRLE/oN1GTdnKJPQlCNXi4o=;
        b=H00oDUlbNL2Kip5Yz9LPHrqqv/fhbr+3GNLrd3uL2ilIeVt1WNJbiuaNYrSAqPdduH
         ZVvu+JDPuMPuB287VU7MAww9QUsIZrVcVy9tXUHdLItEXtkLo5u/QRBDJ1wiAly7kKse
         iIWrJ9dvVuvQe1xNsD4EvZm/WFuAPaHpbOpTR9eVYVdgxoX44XWJukdneObD1oBgdcu5
         ICENOO8ZX3NlChYol6wqq4BlKx3FOwFF52wk0UZC/eMrQBvZ8iah3upckSdfVAT4VA3T
         ZPA2hHqkssnwpZZ/VBK/n49UW5VWAv+ovDDKb3nHo76blUD9ZrkSuWWC8hsBdz7eVGK0
         gRXA==
X-Gm-Message-State: AOAM530bqNjjhJCahiSv5D6zB1O0olYz/LS6jfJbUZUcccgv7r7OyLtT
        ZnnJTkLHIXhQ3Wr4zM+3MA==
X-Google-Smtp-Source: ABdhPJz3tgjVJfWmKgbca9UKRH91w/uITuWlBZmCUxlAapxTJ2vbbhF42rvUio4LeFbH5FQ87AzDoQ==
X-Received: by 2002:a63:531e:: with SMTP id h30mr14203467pgb.158.1615060798907;
        Sat, 06 Mar 2021 11:59:58 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id c12sm5944246pjq.48.2021.03.06.11.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:59:58 -0800 (PST)
Received: (nullmailer pid 1124050 invoked by uid 1000);
        Sat, 06 Mar 2021 19:59:53 -0000
Date:   Sat, 6 Mar 2021 11:59:53 -0800
From:   Rob Herring <robh@kernel.org>
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Joe Sandom <joe.sandom@outlook.com>, jic23@kernel.org
Subject: Re: [RESEND][PATCH v4 2/2] Added AMS tsl2591 device tree binding
Message-ID: <20210306195953.GA1123991@robh.at.kernel.org>
References: <20210222212313.29319-1-joe.g.sandom@gmail.com>
 <20210222212313.29319-2-joe.g.sandom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222212313.29319-2-joe.g.sandom@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Feb 2021 21:23:13 +0000, Joe Sandom wrote:
> Device tree binding for AMS/TAOS tsl2591 ambient light sensor.
> 
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
> 
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.
> 
> Datasheet Available at: https://ams.com/tsl25911
> 
> Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> ---
> Changes in v4:
> - Corrected id field to include vendor name in prefix
> 
> Notes:
> - Previously incorrectly included binding in same patch as driver.
>   This was pointed out by the maintainer and has now been changed to
>   a patch series. Sorry for the confusion!
> 
> Reason for re-send;
> - Maintainer email was outlook address, changed to gmail address as this
>   is the email the patch is being sent from.
> 
>  .../bindings/iio/light/amstaos,tsl2591.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
