Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CCB199FC2
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 22:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCaUGP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 16:06:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40131 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCaUGO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 16:06:14 -0400
Received: by mail-io1-f65.google.com with SMTP id k9so23180263iov.7;
        Tue, 31 Mar 2020 13:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wcJV+sTCvoXRorMTo3bla0YIvIY9cRD9ViFSeOd4nhY=;
        b=IBuyMOPx6WPfsVnrNpd6GbkrI6eXp6ahtCn0nVytcL0vYvafj9LpssY69tZ4y/Llu4
         Kb4PR67S3T5zZ4xcBvX+AB8aLrVwEqDFNEB/Vva1Rt+guEpIsoE5+2EYe7dT6HxclOOh
         jyXt743kd33Az8F4wdn14X6GgBIg9VqxJwzZLkGWJ/IOanApkH0Wfoi+7gf4+K55GWwN
         n6INkEbP3xal54GoNZIhtvxRkK69l7htmQrtQfY7i5GVmBfbR+hPY1gPuCQQL/fIwGkp
         6j2pc9hwnCppEXAb4cNdHVEYgK7/kb7SoDb9izGXcPPJG7tFK1L39uG+NDolBRu1UuEI
         LFaQ==
X-Gm-Message-State: ANhLgQ2no+aglnPEJwhOHbJfPB6D/iPNlnQyX1dA+ueRR6eVtlkUblV1
        lRzXQ65dqpdhiF3dCCE95g==
X-Google-Smtp-Source: ADFU+vuiVI5b8z8thkcndKw6U1+iSGDIMWVZ0mMnFrO0LB3iYtaFNhiK7560NgAcRwmO5JbsytVojg==
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr10379413iob.179.1585685173591;
        Tue, 31 Mar 2020 13:06:13 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s25sm6221528ilb.37.2020.03.31.13.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:06:12 -0700 (PDT)
Received: (nullmailer pid 13332 invoked by uid 1000);
        Tue, 31 Mar 2020 20:06:11 -0000
Date:   Tue, 31 Mar 2020 14:06:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
Message-ID: <20200331200611.GA10950@bogus>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 09:14:10PM +0530, Jishnu Prakash wrote:
> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.
> 
> In addition, add definitions for ADC channels and virtual channel
> definitions per PMIC, to be used by ADC clients for PMIC7.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c                 | 239 ++++++++++++++++++++-
>  drivers/iio/adc/qcom-vadc-common.c               | 260 +++++++++++++++++++++++
>  drivers/iio/adc/qcom-vadc-common.h               |  14 ++
>  include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h  |  67 ++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h |  88 ++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h |  46 ++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h |  28 +++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h |  28 +++
>  include/dt-bindings/iio/qcom,spmi-vadc.h         |  78 ++++++-

DT headers go in the binding patch(es).

>  9 files changed, 843 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
