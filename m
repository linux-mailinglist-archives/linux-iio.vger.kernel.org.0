Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3381A8F8B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 02:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbgDOAJj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 20:09:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37593 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbgDOAJg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 20:09:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id r25so2212881oij.4;
        Tue, 14 Apr 2020 17:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiDDE0DyhBloF7hIDJ2bI5/ecfmmCHzUlHKjb1D+bpM=;
        b=OWuCPgl6fSRAE5kvjfEnaP8iGQRNqkjzhHL5tAiA34MGc6gnu5X3VFagVL7qt/qKyf
         M2ycrhyPrp2KBgvbKO5ouXivqXnc09BliquDwbIUoZSX4ojVxCMTKQ1xyOFZr+n7F9su
         5F/gYR2+X9Lij7lmipwXEx3aIr2jdxXCqmnrmiK0ys+z1dyC1sH2SYTI+Vb33qnsa4AF
         Lb0AOCqJpWq+yumg9hi7mFT1X1NhYS8mNOBTIvQaQvCRZccOKsregaWJUaJRgAmfY4zj
         5YVlDfEfMCU3hsfltRuYga7VaGLvVWSBPco+P0KIKhZJiXsCU8kbTVWt/4LfC6VTlPH0
         if1w==
X-Gm-Message-State: AGi0PuZXk0wa5Mu704m1qZsfpAIxz1yZcndj87Z4yTF/Vjg1N5lNk3pU
        Dj4ats2c4cBElDEvb898pA==
X-Google-Smtp-Source: APiQypIqWFfEFpmn7X8Ecvx8nJkbWUS/T7ILIV+dk2IFwpicn/g+8xtoLV7zzaOU8QZjqTq3TY386w==
X-Received: by 2002:aca:c311:: with SMTP id t17mr16585790oif.169.1586909375378;
        Tue, 14 Apr 2020 17:09:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 186sm6360665ooi.30.2020.04.14.17.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:09:34 -0700 (PDT)
Received: (nullmailer pid 23835 invoked by uid 1000);
        Wed, 15 Apr 2020 00:09:33 -0000
Date:   Tue, 14 Apr 2020 19:09:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nick Reitemeyer <nick.reitemeyer@web.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Alps
Message-ID: <20200415000933.GA23792@bogus>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406141350.162036-1-nick.reitemeyer@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Apr 2020 16:13:49 +0200, Nick Reitemeyer wrote:
> 
> Alps Electric Co., Ltd. is a japanese electronics company:
> https://www.alps.com/
> 
> Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
