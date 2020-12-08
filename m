Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8752D2918
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgLHKk7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 05:40:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2220 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgLHKk6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 05:40:58 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqxTv6ZD2z67DLr;
        Tue,  8 Dec 2020 18:38:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 11:40:16 +0100
Received: from localhost (10.47.68.59) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 8 Dec 2020
 10:40:15 +0000
Date:   Tue, 8 Dec 2020 10:39:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: Re: [PATCH v10 00/15] qcom: pm8150: add support for thermal
 monitoring
Message-ID: <20201208103951.00003b3a@Huawei.com>
In-Reply-To: <4de94396-54c7-e741-b288-3a3868515f7b@linaro.org>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
        <20201205170830.4d56ecb7@archlinux>
        <4de94396-54c7-e741-b288-3a3868515f7b@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.68.59]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Dec 2020 00:05:29 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On 05/12/2020 20:08, Jonathan Cameron wrote:
> > On Fri,  4 Dec 2020 05:54:54 +0300
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >   
> >> This patch serie adds support for thermal monitoring block on Qualcomm's
> >> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> >> to support thermal zones provided by this thermal monitoring block.
> >> Unlike the rest of PMIC thermal senses, these thermal zones describe
> >> particular thermistors, which differ between from board to board.  
> > 
> > I've just taken another look through the various IIO parts in here and
> > I think they are fine.
> > 
> > My assumption is that given the timing this isn't going to make the merge
> > window now.  Hence I'll be looking to do an immutable branch based on rc1
> > once it's available (assuming everyone else is fine with this version).  
> 
> Thank you! Another option might be to merge all iio changes this cycle 
> (if it's fine with you) and have all the rest go via respective trees in 
> the next merge window. I'm fine with either of the options.

Too late unfortunately. IIO routes through staging for historical reasons
(plus we still have about 15 drivers to move out of there - it's only been
about 10 years :)  Staging closes a week before merge window so IIO closes a few
days before staging.

So lets stick to the immutable branch method.  Tends to make more sense in
the git history anyway as brings relevant code together (even if it travels
via multiple routes :)

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >>
> >> Changes since v9:
> >>   - In patch 12 add comments to the code as requested by Daniel Lezcano.
> >>   - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
> >>     driver history.
> >>
> >> Changes since v8:
> >>   - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
> >>     tables support
> >>   - Simplified qcom-vadc-common volt/temp mapping code
> >>   - Implement suggestions by Matthias Kaehlcke: message formatting,
> >>     rewrite comments, remove unused variable initialization.
> >>
> >> Changes since v7:
> >>   - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
> >>   - Use explicit sizeof(var) instead of hand-coding 1 when accessing
> >>     adc-tm registers.
> >>   - Remove buffer read from adc_tm5_init().
> >>   - Remove extra on-stack var from adc_tm5_get_temp().
> >>   - Minor formatting changes as suggested Daniel.
> >>
> >> Changes since v6:
> >>   - Added include <linux/bitfield.h> as noted by Jishnu Prakash.
> >>
> >> Changes since v5:
> >>   - Reworked DT bindings:
> >>     * Removed qcom,adc-channel, instead it is parsed from io-channels
> >>     * Renamed qcom,hw-settle-time to include -us suffix
> >>   - Re-added monitor enabling which got lost during refactored. Noted by
> >>     Jishnu Prakash.
> >>   - Use threaded IRQ handler as susggested by Jishnu.
> >>
> >> Changes since v4:
> >>   - Added kernel-doc comments to ADC-TM structures
> >>   - Used several sizeof(buf) instead of hand-conding register size
> >>
> >> Changes since v3:
> >>   - Fix DT description to spell "thermal monitoring" instead of just TM
> >>   - Fix warnings in DT example
> >>   - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
> >>   - Fixed whitespace chanes in qcom-vadc-common.c
> >>   - Removed error message if IIO chanel get returns -EPROBE_DEFER
> >>
> >> Changes since v2:
> >>   - IIO: export of_iio_channel_get_by_name() function
> >>   - dt-bindings: move individual io-channels to each thermal monitoring
> >>     channel rather than listing them all in device node
> >>   - added fallback defaults to of_device_get_match_data calls in
> >>     qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
> >>   - minor typo fixes
> >>
> >> Changes since v1:
> >>   - Introduce fixp_linear_interpolate() by Craig Tatlor
> >>   - Lots of syntax/whitespace changes
> >>   - Cleaned up register definitions per Jonathan's suggestion
> >>   - Implemented most of the suggestions from Bjorn's and Jonathan's
> >>     review
> >>
> >>  
> >   
> 
> 

