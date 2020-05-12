Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564801D01B7
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgELWP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 18:15:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34088 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELWPZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 18:15:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so11894445otu.1;
        Tue, 12 May 2020 15:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVK89xhRe2dqqDXZV23LSGBYPhwnN3G4S7xp2PFGVdI=;
        b=XtTwkDrabtjrovPji6l0Lr7lNlKHOfU2fpXXge07wiM+usxTmJdiIspZV3izgkUGsp
         sYzo/dzCj4Xb5uK7T0RlZGFakmrbuS6pU/5Ko9R/6jQr1wdvDgLPs4y/00fJa57BnNGF
         rw4nMjb2Jzygo0tSlGYXb7l519kAcLEdYqzEtMB5FJXT3WU+6KEr8+ZBevdPHLBMQr6m
         NId0Ejp1MI3KkLQ34QMowgZVJoIwlnV3zaQ2qk/Hxug1v/pSpliEejoqj/aPOGnIONXB
         izO8hBKt0jM9hUUukRcqfBMSJ/mu4G0yvAY5JIfr+/h2CcL0/VmsInm/XFIsqPeJMKnR
         i7yg==
X-Gm-Message-State: AOAM5316oqF/OtKpulJAK1ES+3/jaBCQsyAnbP+RwH+WLZwk8chHJGKO
        kbT0Ka9NzVFS6YmeyY6X7Q==
X-Google-Smtp-Source: ABdhPJyfKrzJI16lw/o2fIOXkY8zYYu+QkLPs46lpYKMfjC19TZCtZS9F0AGfDdkuJj4YopFYnat8g==
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr1286689otl.314.1589321724576;
        Tue, 12 May 2020 15:15:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a93sm3775301otc.12.2020.05.12.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:15:24 -0700 (PDT)
Received: (nullmailer pid 31615 invoked by uid 1000);
        Tue, 12 May 2020 22:15:23 -0000
Date:   Tue, 12 May 2020 17:15:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     knaack.h@gmx.de, tglx@linutronix.de, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        robh+dt@kernel.org, kstewart@linuxfoundation.org,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: iio: accel: Add required regulators to
 bma180
Message-ID: <20200512221522.GA31552@bogus>
References: <20200503172206.13782-1-xc-racer2@live.ca>
 <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 May 2020 10:22:05 -0700, Jonathan Bakker wrote:
> The bma180 and related chips should have two registers attached to
> them.  The IIO driver currently uses them, document them here as
> well.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  Documentation/devicetree/bindings/iio/accel/bma180.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
