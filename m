Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9588E1CEA4E
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 03:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgELBxk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 21:53:40 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42755 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgELBxj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 21:53:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so9240060otq.9;
        Mon, 11 May 2020 18:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=daFGYc0o3GvaIjPzR6/Udzzo+tWkkyO8hcjap5qbb9s=;
        b=rAPYIyvPktcQBkvsNMQPf03clZxcHy2Ni04E6qIkzy4uSyBTh31u1KCoIiTqR099pC
         03UK55XaqerqRx+4FAThgoy+5KyxRyvlR7mG0WbCoj9vh1NKsGuP5lFXiifxCuoVHbC1
         cDyq0IdtrnBpRaKzLMHX3yCGB9UmRX/sN7mRHILRHnrodMM4//fT5yiHDD/kWQBvcxrz
         SqDaZkf+OnvYGoI+sfzK18bhZYwUFLmx9NtSRS8I2/u32LBSNLFsnryy1H5oXuI03KGl
         Ps2jXMQtJPaLnoP6lQ17uAhKvWReIA91OqEZ7mtB1dHw9oEdbj1iYK4BXlU+w+4jxpBW
         HGpg==
X-Gm-Message-State: AGi0PuZGiMWLTJG4enFLHDThbrQdBc6ZlTwJrkAHaNuPiYUqc0JY14Qs
        WuxNPibtuSxOqC9bpjURuQ==
X-Google-Smtp-Source: APiQypIxgXqdx3cx31SCjMZl/t8jJMjD1vREWgFc4w7UpMQFE2oKD32mY52N/woXbeBeF4cYmIRKnA==
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr14040732oti.329.1589248418475;
        Mon, 11 May 2020 18:53:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l21sm3263751ooq.18.2020.05.11.18.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 18:53:37 -0700 (PDT)
Received: (nullmailer pid 14764 invoked by uid 1000);
        Tue, 12 May 2020 01:53:36 -0000
Date:   Mon, 11 May 2020 20:53:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>, devicetree@vger.kernel.org,
        mka@chromium.org, Jonathan.Cameron@huawei.com,
        linux-arm-msm-owner@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, agross@kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        bjorn.andersson@linaro.org, smohanad@codeaurora.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        aghayal@codeaurora.org, kgunda@codeaurora.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V3 2/4] iio: adc: Add PMIC7 ADC bindings
Message-ID: <20200512015336.GA14725@bogus>
References: <1587993846-30773-1-git-send-email-jprakash@codeaurora.org>
 <1587993846-30773-3-git-send-email-jprakash@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587993846-30773-3-git-send-email-jprakash@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 18:54:03 +0530, Jishnu Prakash wrote:
> Add documentation for PMIC7 ADC peripheral.
> For the PMIC7-type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8350, PM8350, PM8350b, PMR735a and PMR735b.
> Of these, only the ADC peripheral on PMK8350 is exposed directly to SW.
> If SW needs to communicate with ADCs on other PMICs, it specifies the
> PMIC to PMK8350 through the newly added SID register and communication
> between PMK8350 ADC and other PMIC ADCs is carried out through
> PBS(Programmable Boot Sequence) at the firmware level.
> 
> In addition, add definitions for ADC channels and virtual channel
> definitions (combination of ADC channel number and PMIC SID number)
> per PMIC, to be used by ADC clients for PMIC7.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 38 ++++++++--
>  include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    | 67 ++++++++++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   | 88 ++++++++++++++++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   | 46 +++++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   | 28 +++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   | 28 +++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h           | 78 ++++++++++++++++++-
>  7 files changed, 366 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
