Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C806154E5F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBFVwg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 16:52:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43180 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFVwg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 16:52:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so3412467pgc.10;
        Thu, 06 Feb 2020 13:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtdzqnFbYBCvi9ExcMSjlC82MNqpwwImTBc/WnOaN6k=;
        b=ACSNtke8GAbIhgMmZzpRWvmSc9fdBV9BFA3ZHcgco+r+kCcQQvO2iPPZ8QtYPwYqTR
         Mn0GGcBFJ9lbEMOCHRYadFq1VP5GVJRIryD/3H5A0r5n6csVKQbxGM594iRFmqzU2U5e
         9Qn2L5lGzxC0OK+xSt01u0sR7e6ELEFX7fmHRwtFtk7LV5X46Id9NU5Hc/eIsPSnWPVW
         59FlOXOCuzZyJF6DkY+umxqAfs9mrOqNZ8WUIOVpXd/Pi0fNi3CUZwgGAUk2M6dKZvsP
         oafB1kyWsIm/IC/53X0OPb8dE0lJX2V7cUzzXXRE5CD5pNeDjAVKH2rT9OmspiJ7p77Z
         CKwg==
X-Gm-Message-State: APjAAAXlogsH8cTAvq8hd/2hUXuRdCMuRZR55aicg/TZRv+MV98GYSEP
        CBVrpQuF3HVQBsWo4EiHOQ==
X-Google-Smtp-Source: APXvYqwaFOqRlvpMxkGTCo4EtvXfZfUY0Dj/TNqM5kt+/273ObTUwIN/lBf/e5g/AOqrfve9igNUvQ==
X-Received: by 2002:a62:188:: with SMTP id 130mr6311789pfb.249.1581025955567;
        Thu, 06 Feb 2020 13:52:35 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id q28sm353053pfl.153.2020.02.06.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:52:34 -0800 (PST)
Received: (nullmailer pid 11642 invoked by uid 1000);
        Thu, 06 Feb 2020 21:52:33 -0000
Date:   Thu, 6 Feb 2020 14:52:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: chemical: consolidate
 atlas-sensor docs
Message-ID: <20200206215233.GA11472@bogus>
References: <20200206061332.20427-1-matt.ranostay@konsulko.com>
 <20200206061332.20427-4-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206061332.20427-4-matt.ranostay@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 22:13:32 -0800, Matt Ranostay wrote:
> Since Atlas Scientific device support only varies from the compatible
> string is ideal all the respective docs are merged into a single doc
> named atlas,sensor.yaml
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 --------
>  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 --------
>  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 --------
>  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++++++++++
>  4 files changed, 53 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
