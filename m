Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505371A7DEF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgDNN17 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 09:27:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47000 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbgDNN1a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 09:27:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id w12so11846967otm.13;
        Tue, 14 Apr 2020 06:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVOrryvCDyDzAReH6aIbRFN6ox59JAupWWFfUSqcRpo=;
        b=d/5iUeg7ldwFGNjlf0I4yj7dwihJCsxzK4RKBLrJOEjPoiyIhHMskU23IK+PRBCPHl
         8blhtjFNWYgYb9usemn9rDrH/fQKBmJ2glzamUFuG9J3F3JbjIVPuFDaA3vMLe1rW9qj
         0eNEGKDarbMuniR4+6IEpn1ur2ZoXiSKKUWUrxHAgR3UmrXFF+1v4AHzQigb6G8sFOod
         tglzsI4UKCR5UFbi73U7cFA+fk0K5FTl4sjJUX0ehvmMX/eIqZIrtL74hvQhJyz0Y5XF
         /n5CcP4Wt5nJVFmhsSc3myLFon+7xZCBTBEOVdzrDFKnXUOwWccPg/S0Ci3rjm+SgOY6
         PErQ==
X-Gm-Message-State: AGi0PuZ5/V8V9/KxSrMIYeNxtsWVAkBFtAHuZ3Lcaw21bHzuEj+Sljj5
        GIwbEyrHM1lfuT7Z6o5Mew==
X-Google-Smtp-Source: APiQypItK97VCLMFJOCetQWUYA10rucw28vlh7IDOBTk/n7W97an4qYXIGyRPJa67VV1uK2zXOVlQA==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr5747574otn.227.1586870839359;
        Tue, 14 Apr 2020 06:27:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm5579322otq.9.2020.04.14.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:27:18 -0700 (PDT)
Received: (nullmailer pid 16564 invoked by uid 1000);
        Tue, 14 Apr 2020 13:27:17 -0000
Date:   Tue, 14 Apr 2020 08:27:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     mani@kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: chemical: Add binding for CCS811
 VOC sensor
Message-ID: <20200414132717.GA15437@bogus>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-2-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412183658.6755-2-mani@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 00:06:56 +0530, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> This commit adds devicetree binding for AMS CCS811 VOC sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../bindings/iio/chemical/ams,ccs811.yaml     | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/iio/chemical/ams,ccs811.example.dts:24.38-39 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/iio/chemical/ams,ccs811.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/iio/chemical/ams,ccs811.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1269473

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
