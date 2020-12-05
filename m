Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA562CFCAF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgLESTU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgLERyc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 12:54:32 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D63A22D72;
        Sat,  5 Dec 2020 17:08:34 +0000 (UTC)
Date:   Sat, 5 Dec 2020 17:08:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: Re: [PATCH v10 00/15] qcom: pm8150: add support for thermal
 monitoring
Message-ID: <20201205170830.4d56ecb7@archlinux>
In-Reply-To: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  4 Dec 2020 05:54:54 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> This patch serie adds support for thermal monitoring block on Qualcomm's
> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> to support thermal zones provided by this thermal monitoring block.
> Unlike the rest of PMIC thermal senses, these thermal zones describe
> particular thermistors, which differ between from board to board.

I've just taken another look through the various IIO parts in here and 
I think they are fine.

My assumption is that given the timing this isn't going to make the merge
window now.  Hence I'll be looking to do an immutable branch based on rc1
once it's available (assuming everyone else is fine with this version).

Thanks,

Jonathan

> 
> Changes since v9:
>  - In patch 12 add comments to the code as requested by Daniel Lezcano.
>  - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
>    driver history.
> 
> Changes since v8:
>  - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
>    tables support
>  - Simplified qcom-vadc-common volt/temp mapping code
>  - Implement suggestions by Matthias Kaehlcke: message formatting,
>    rewrite comments, remove unused variable initialization.
> 
> Changes since v7:
>  - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
>  - Use explicit sizeof(var) instead of hand-coding 1 when accessing
>    adc-tm registers.
>  - Remove buffer read from adc_tm5_init().
>  - Remove extra on-stack var from adc_tm5_get_temp().
>  - Minor formatting changes as suggested Daniel.
> 
> Changes since v6:
>  - Added include <linux/bitfield.h> as noted by Jishnu Prakash.
> 
> Changes since v5:
>  - Reworked DT bindings:
>    * Removed qcom,adc-channel, instead it is parsed from io-channels
>    * Renamed qcom,hw-settle-time to include -us suffix
>  - Re-added monitor enabling which got lost during refactored. Noted by
>    Jishnu Prakash.
>  - Use threaded IRQ handler as susggested by Jishnu.
> 
> Changes since v4:
>  - Added kernel-doc comments to ADC-TM structures
>  - Used several sizeof(buf) instead of hand-conding register size
> 
> Changes since v3:
>  - Fix DT description to spell "thermal monitoring" instead of just TM
>  - Fix warnings in DT example
>  - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
>  - Fixed whitespace chanes in qcom-vadc-common.c
>  - Removed error message if IIO chanel get returns -EPROBE_DEFER
> 
> Changes since v2:
>  - IIO: export of_iio_channel_get_by_name() function
>  - dt-bindings: move individual io-channels to each thermal monitoring
>    channel rather than listing them all in device node
>  - added fallback defaults to of_device_get_match_data calls in
>    qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
>  - minor typo fixes
> 
> Changes since v1:
>  - Introduce fixp_linear_interpolate() by Craig Tatlor
>  - Lots of syntax/whitespace changes
>  - Cleaned up register definitions per Jonathan's suggestion
>  - Implemented most of the suggestions from Bjorn's and Jonathan's
>    review
> 
> 

