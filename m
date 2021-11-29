Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D6460BD9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Nov 2021 01:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhK2AvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 19:51:11 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34452 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhK2AtL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 19:49:11 -0500
Received: by mail-oi1-f175.google.com with SMTP id t19so31431299oij.1;
        Sun, 28 Nov 2021 16:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUMZtYVmOKmzKWvEgBBAy6Os4t7757ETuxyl2/LzMms=;
        b=l63ct9OnqiYS2uKJnSY6zec3v89HTvLoTdpI+Rmjmf1Sba4CxnaIcE0LjecBxUXZv1
         kTz4IYyxGEe0vMTOyXUvfBKwiz4azY4M+WoDmD0p6SdILcVlJYlTRw7ZHtGyjEpWsLOr
         sb+tbTeYLtQ+GXUa04Baa9Z7+vphgCSOBZAdRnM1MbgW7j1mRkxSq9+LjFLsLfjw/GqZ
         GiRLyETQu2xH+zsCZ77uXXqulMFKBEk9B8jjEbQNd466CvFWDkNdt87g8OIj12jLIqwW
         i7balQUB8PCeIjL63vxDFbx64posejVd/P+qComgcrHsU3c4Kt5z0jTLJIJhEKXzoBc6
         xVAQ==
X-Gm-Message-State: AOAM532JNGljyoFat/+H0XEMUs+9DVViCdSOE2WWEN3jGHpOqY2fqD7W
        QKmNXVMuzxFARur5IBhwew==
X-Google-Smtp-Source: ABdhPJwiTS7PZPgXfbF/PFr//hEYE9Ia5kHLXct2UKvI7VLCBOfrMizjd5E8aog3TgjSpBFn3t16Qw==
X-Received: by 2002:a05:6808:2388:: with SMTP id bp8mr38048904oib.38.1638146754406;
        Sun, 28 Nov 2021 16:45:54 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id a6sm2695366oic.39.2021.11.28.16.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:45:53 -0800 (PST)
Received: (nullmailer pid 2912174 invoked by uid 1000);
        Mon, 29 Nov 2021 00:45:40 -0000
Date:   Sun, 28 Nov 2021 18:45:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     rui.zhang@intel.com, pmeerw@pmeerw.net,
        manivannan.sadhasivam@linaro.org, jic23@kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, quic_subbaram@quicinc.com,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_aghayal@quicinc.com,
        lars@metafoo.de, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm-owner@vger.kernel.org, linus.walleij@linaro.org,
        quic_kgunda@quicinc.com, amitk@kernel.org,
        dmitry.baryshkov@linaro.org, knaack.h@gmx.de
Subject: Re: [PATCH V3 1/4] dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM
 bindings
Message-ID: <YaQitCoPQRqFuZaO@robh.at.kernel.org>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
 <1637647025-20409-2-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637647025-20409-2-git-send-email-quic_jprakash@quicinc.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 11:27:01 +0530, Jishnu Prakash wrote:
> Add documentation for PMIC5 Gen2 ADC_TM peripheral.
> It is used for monitoring ADC channel thresholds for PMIC7-type
> PMICs. It is present on PMK8350, like PMIC7 ADC and can be used
> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
> on a target, through PBS(Programmable Boot Sequence).
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
