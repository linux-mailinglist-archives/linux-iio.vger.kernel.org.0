Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF371CEA3F
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 03:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgELBtO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 21:49:14 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:45656 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgELBtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 21:49:14 -0400
Received: by mail-oo1-f68.google.com with SMTP id p123so1226044oop.12;
        Mon, 11 May 2020 18:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qyS6MkhXHBKw55KmTZ5skJnQyiabgnNPBApKYQW8lbs=;
        b=WTOs/5YsBeW8Irx6ICXsJVMl11WiUFktKwdQ49CajcqrvNMFVBQykk8lY91rn3YC0A
         8a6D+nO/dvBNuHmqpcf38nPgV/SQVeax1OsDqDeyBrGx7xm1U4/mz5A4ShOwxbnIlLSU
         7lIOQApCPRwOF1sRm/7FrSM6OQqF/4zeBQ1suz8U7KdrNPrzlyNbT3kdR2RW4VbMemFF
         W44tDtoh65HOIe9PYnOkwRJe3NN83aLB5P2XGbb0LqcLb8z3+uvlxP8AEq/UWiXoprbB
         wsCYhY8LSCHGynfaWAlQpAeLJmdLyOxkKQTedw5sumqzc2OO/WOo7S8+MwGq2VL5FKA7
         IIfA==
X-Gm-Message-State: AGi0Pubsc/+DyIMmdU8YOplBHZl/nlDHxEJsejUKH8BjGN11H2Hnfb0E
        cfcLzTrQRtQyt4Uj4Ho/Mg==
X-Google-Smtp-Source: APiQypKdwSaX0fVfyQQECJ+IcqIuXGQV1KHcMgLThCmBXgBvOFuAaR2UI6Zz6VxsqyMDL6UwN37aSg==
X-Received: by 2002:a4a:3ed6:: with SMTP id t205mr4101984oot.51.1589248153449;
        Mon, 11 May 2020 18:49:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j3sm3112516otq.22.2020.05.11.18.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 18:49:12 -0700 (PDT)
Received: (nullmailer pid 8810 invoked by uid 1000);
        Tue, 12 May 2020 01:49:11 -0000
Date:   Mon, 11 May 2020 20:49:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     Jonathan.Cameron@huawei.com, Mark Rutland <mark.rutland@arm.com>,
        linus.walleij@linaro.org, Lars-Peter Clausen <lars@metafoo.de>,
        mka@chromium.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>, agross@kernel.org,
        kgunda@codeaurora.org, bjorn.andersson@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
        smohanad@codeaurora.org, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 1/4] iio: adc: Convert the QCOM SPMI ADC bindings to
 .yaml format
Message-ID: <20200512014911.GA8752@bogus>
References: <1587993846-30773-1-git-send-email-jprakash@codeaurora.org>
 <1587993846-30773-2-git-send-email-jprakash@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587993846-30773-2-git-send-email-jprakash@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 18:54:02 +0530, Jishnu Prakash wrote:
> Convert the adc bindings from .txt to .yaml format.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 --------------
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 252 +++++++++++++++++++++
>  2 files changed, 252 insertions(+), 173 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
