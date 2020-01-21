Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7A1446E5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2020 23:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAUWHI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jan 2020 17:07:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35594 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWHI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jan 2020 17:07:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so4475043oto.2;
        Tue, 21 Jan 2020 14:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mf/yLE4fhksL4+41Ux+KrRepfjoWtmsOsdPONyuKv80=;
        b=GoxSp8PM84NKJRzelQAidPqEN2Qc5fK9Q5YlOfplvlTrgP3nK1aeZW0LmekATfW9ZD
         DHarhSIGlFPDAnrbTkt4I2tUJE4k3GHv50zbhGWD9F0FnqXZP+jcW9nnDsj9EkExifwC
         ZAoNJ82ug/R+J2WPGFA8TlbzLqotvV1UG/FVtyVlpOn3E2qNYMVmvRtj27gOVoCnrkEB
         dp25JNY0YDrhhh9ju8NDMkBeULgegYB58UlLY07LCm4waTIh2MqjRS7d32XxGOIU5vdm
         RlrTnFASvTYE2CQTk3tJpP/92BkQ4/JjX4Octze62zJ+TWemTBHk1+kVrPlQNBFXFzcC
         uAtQ==
X-Gm-Message-State: APjAAAU+lS8uzN2wbNnsqA0nRnqdZGZwXjxljrzo2Or/oCJfGQAjWuHv
        ESoOON8Jy+u6z4XjkZGnEXJpX8o=
X-Google-Smtp-Source: APXvYqyUPROewNgBwvEiDeEneFjZDF2in+v16Msxe/0x8RMLHkcmdQx2vG0w1GAJjHM/GUJh7O8FFw==
X-Received: by 2002:a9d:7f83:: with SMTP id t3mr4991921otp.115.1579644427111;
        Tue, 21 Jan 2020 14:07:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e65sm14081508otb.62.2020.01.21.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:07:06 -0800 (PST)
Received: (nullmailer pid 23030 invoked by uid 1000);
        Tue, 21 Jan 2020 22:07:05 -0000
Date:   Tue, 21 Jan 2020 16:07:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, jic23@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: consolidate
 atlas-sensor docs
Message-ID: <20200121220705.GA15425@bogus>
References: <20200114022348.8676-1-matt.ranostay@konsulko.com>
 <20200114022348.8676-4-matt.ranostay@konsulko.com>
 <20200116182124.00006e19@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116182124.00006e19@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 16, 2020 at 06:21:24PM +0000, Jonathan Cameron wrote:
> On Tue, 14 Jan 2020 04:23:48 +0200
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> 
> > Since Atlas Scientific device support only varies from the compatible
> > string is ideal all the respective docs are merged into a single doc
> > named atlas,sensor.txt
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> 
> No chance of a yaml conversion whilst you are at it?

I asked for that on v1.

> Maybe dt maintainers will take the view this is step in the right direction and
> let this go, but I will want an Ack for that.

When I can get 4 for the price of 1, I'll take the conversion. :) 

> > ---
> >  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 ------------
> >  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 ------------
> >  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 ------------
> >  .../bindings/iio/chemical/atlas,sensor.txt    | 34 +++++++++++++++++++
> >  4 files changed, 34 insertions(+), 63 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.txt
