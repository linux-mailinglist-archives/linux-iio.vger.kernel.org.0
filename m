Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE47B78DA86
	for <lists+linux-iio@lfdr.de>; Wed, 30 Aug 2023 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjH3Sga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 30 Aug 2023 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjH3Q3W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Aug 2023 12:29:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB79C107
        for <linux-iio@vger.kernel.org>; Wed, 30 Aug 2023 09:29:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbV4k2mQbz688hZ;
        Thu, 31 Aug 2023 00:24:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 17:29:13 +0100
Date:   Wed, 30 Aug 2023 17:29:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno Sa <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH 0/3] Add converter framework
Message-ID: <20230830172903.0000027f@Huawei.com>
In-Reply-To: <20230804145342.1600136-1-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Aug 2023 16:53:38 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> This is the initial RFC following the discussion in [1]. I'm aware this is
> by no means ready for inclusion and it's not even compilable since in
> the RFC I did not included the patch to add component_compare_fwnode()
> and component_release_fwnode(). 

Whilst I haven't read this through yet, I suspect Olivier will be able to
offer some insight on some of this and likewise you may be able to
point out pitfalls etc in his series (I see you did some review already :)

https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan@foss.st.com/

Both are about multiple interacting components of an overall datapath.
Whether there is commonality isn't yet clear to me.

> 
> The goal is to have a first feel on the
> direction of the framework so that if I  need to drastically change it,
> better do it now. The RFC also brings the ad9647 and the axi_adc core to
> the same functionality we have now upstream with one extra fundamental
> feature that is calibrating the digital interface. This would be very
> difficult to do with the current design. Note that I don't expect any
> review on those drivers (rather than things related to the framework). 
> 
> I also want to bring up a couple of things that I've
> been thinking that I'm yet not sure about (so some feedback might make
> mind in one direction or another).
> 
> 1) Im yet not sure if I should have different compatibles in the
> axi-adc-core driver. Note this soft core is a generic core and for every
> design (where the frontend device changes or has subtle changes like
> different number of data paths) there are subtle changes. So, the number
> of channels might be different, the available test patterns might be
> different, some ops might be available for some designs but not for
> others, etc... 

I don't suppose there is any chance Analog can make at least some of this
discoverable from the hardware?  Capability registers etc in the long
run. Can't fix what is already out there.

> With a different compatible we could fine tune
> those differences (with a chip_info like structure) and pass some const
> converter_config to the framework that would allow it to do more safety
> checks and potentially reduce the number of converter_ops.
> OTOH, starting to add all of these compatibles might become messy in the
> long run and will likely mean that we'll always have to change both
> drivers in order to support a new frontend. And the frontend devices
> should really be the ones having all the "knowledge" to configure the
> soft core even if it means more converter_ops (though devicetree might
> help as some features are really HW dependent). I more inclined to just
> leave things as-is in the RFC.

I'm fine with putting this stuff in DT where possible.

> 
> 2) There are some IIO attributes (like scale, frequency, etc) that might
> be implemented in the soft cores. I still didn't made my mind if I should just
> have a catch all read_raw() and write_raw() converter_ops or more fine
> tuned ops. Having the catch all reduces the number of ops but also makes
> it more easier to add stuff that ends up being not used anymore and then
> forgotten. There are also cases (eg: setting sampling frequency) where
> we might need to apply settings in both the frontend and the backend
> devices which means having the catch all write_raw() would be more
> awkward in these case. I'm a bit more inclined to the more specific ops. 

It's the kernel - we can always change the internal API later as long as we
don't touch the user space part.  Go with your gut feeling today and
if it changes this sort of refactor usually isn't that bad.

> 
> 3) I also placed this in addac as this is mostly used in high speed DACs
> and ADCs but maybe we should just have it in the top level directory
> just in case this is started to be used in different type of devices?

Easy to change later so right now I don't care where it is.

> 
> 4) Some function and data names are also starting to become very big so
> if there are no objections I will move all to use conv instead of full
> converter. Or maybe something a bit more generic (converter is a bit specific
> I know)?

Abrv. fine as long as consistenty used.

> 
> I would love to hear some ideas about the above...
> 
> Anyways, I should also mention that the only visible ABI breakage is in
> the IIO device name. Before it was named "adi-axi-adc" and now it's
> "ad9647" which is what makes sense actually. With the current approach
> we would not be able to actually distinguish between designs. 

Given that will probably only result in support calls to ADI I'm fine with
that breakage. :)

> 
> So my plan for the actual series will be to just add the framework and migrate
> the current drivers to it with the same functionality as they have now (not
> sure if it will be viable to migrate the drivers in a way each commit is
> functional - unless we convert both drivers in one commit).
Make sure they build. It's fine to end up with some non functional stubs
during such a migration.

> After that
> point, I will start adding all the missing features (and devices) to the
> ad9467 driver. To note that I also plan to include the axi-dac driver in
> the first series and that will require IIO DMA output buffer support
> so we might need to cherry-pick those patches from Paul's DMABUF series.
As mentioned in reply to that, I'm fine with you carrying Paul's miniseries
in your patch set to make this all easy to manage.

Jonathan

> 
> Thanks!
> - Nuno Sá
> 
> [1]: https://lore.kernel.org/linux-iio/dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com/
> 
> Nuno Sa (3):
>   iio: addac: add new converter framework
>   iio: adc: ad9647: add based on converter framework
>   iio: adc: adi-axi-adc: add based on new converter framework
> 
>  drivers/iio/adc/ad9467_new.c        | 830 ++++++++++++++++++++++++++++
>  drivers/iio/adc/adi-axi-adc-new.c   | 405 ++++++++++++++
>  drivers/iio/addac/converter.c       | 547 ++++++++++++++++++
>  include/linux/iio/addac/converter.h | 485 ++++++++++++++++
>  4 files changed, 2267 insertions(+)
>  create mode 100644 drivers/iio/adc/ad9467_new.c
>  create mode 100644 drivers/iio/adc/adi-axi-adc-new.c
>  create mode 100644 drivers/iio/addac/converter.c
>  create mode 100644 include/linux/iio/addac/converter.h
> 

