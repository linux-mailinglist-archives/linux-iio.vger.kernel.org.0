Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438421D01B0
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 00:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgELWPO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 18:15:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41670 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELWPO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 18:15:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id 63so4479332oto.8;
        Tue, 12 May 2020 15:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tbu1DIGIqC2787Cf3kI4oo0RYxQ+XgRD2HVUCfj6eFM=;
        b=lQqEJAWlAVqSpwB5//wjxIELZ0eeHzdxvwTBzKJG7WgOhlGZAlIKEych40cMWnDMqk
         fuOvAA4X7HKE2JN5TKB754nuvYXCaqR7ciW0q2+yWro5c8wxYGlD6vnPgKgZfi0PpPEY
         fubJm7ud5+uAH33seh0egy29Jx4EOiDMdI1bLCzLsroowM9z2gcAr8SpOsKUMGbODRdN
         B/FGfOxJvq4ruzq5fZiod4Yqsc6OVRuaqUY/nxKhdhbU/I4rfmOc9uwFAMwkXJYIbV5z
         drk9zBYIOhD0/etqPIHscbLYZ34sn+LJcrGIHPTlEhrt7YducGmFuxopLjQfH3y4uf4A
         JPyQ==
X-Gm-Message-State: AGi0PuYKykJ29lrFwN2i15HnvLOwF58O23iXJhEzIkTQqwM2WmjLofgH
        +NtMZ/iheWEYqDtAkIlp4w==
X-Google-Smtp-Source: APiQypK85vLXej1knmug93hZbMVvi5IB6HvO2a4QfAn+0J9ee8Alz6w4wvFH+2897eSC6yKLGIYY9g==
X-Received: by 2002:a05:6830:2091:: with SMTP id y17mr19117937otq.153.1589321713144;
        Tue, 12 May 2020 15:15:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w14sm3973957oou.46.2020.05.12.15.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:15:12 -0700 (PDT)
Received: (nullmailer pid 31223 invoked by uid 1000);
        Tue, 12 May 2020 22:15:11 -0000
Date:   Tue, 12 May 2020 17:15:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jic23@kernel.org, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, pmeerw@pmeerw.net,
        linus.walleij@linaro.org, linux-input@vger.kernel.org,
        lars@metafoo.de, kstewart@linuxfoundation.org, knaack.h@gmx.de,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: iio: accel: Add bma023 compatible to
 bma180
Message-ID: <20200512221511.GA31164@bogus>
References: <20200503172206.13782-1-xc-racer2@live.ca>
 <BN6PR04MB0660DA2A47787A56A2FC7290A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660DA2A47787A56A2FC7290A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 May 2020 10:22:04 -0700, Jonathan Bakker wrote:
> The bma023 is in the same family as the bma180 and support is
> being added to the bma180 IIO driver for it.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  Documentation/devicetree/bindings/iio/accel/bma180.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
