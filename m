Return-Path: <linux-iio+bounces-302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F547F6593
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 18:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFEE2814FF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153A405F2;
	Thu, 23 Nov 2023 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="b70aCcXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB1CB;
	Thu, 23 Nov 2023 09:37:18 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ANFuZqJ004429;
	Thu, 23 Nov 2023 18:36:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=jMY3R2xU/ZwVBI97J7QFraPb7SUjMhRYrpBfJQHd7j4=; b=b7
	0aCcXIyJVjoFSKFdtP0Ebup/h2eRYQITS2uIZoxZBKVb/m+1ZCQVUe72sCXKsJtm
	VBO+3Pntx5is7yA4mMWtghm06dBCHiKbxtDIfuF39XdlzpkYvdelOApGb2zsU/kh
	32D7BF1b9RiWw/telN6LqcjKFgX1MSNX0bXqgRvsLSoq2txE1+IxY0DXOYE2sOuq
	HGwlvbZ6qeIsE7A4TwDOSsSwjlcu9IT6IjOhRqXjD+hcWkmle8r3KfloWEcR3xvh
	dezxjVPQqEfzu1AXes8VEq7lWWY/yG0Q3DFH1iyOXG+VPu6+X74LNLC6GQbx7R5E
	OM0AzcctM4eLElouF8kg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uj4as0k0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 18:36:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66A9810002A;
	Thu, 23 Nov 2023 18:36:47 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56FB52747C5;
	Thu, 23 Nov 2023 18:36:47 +0100 (CET)
Received: from [10.201.21.64] (10.201.21.64) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 23 Nov
 2023 18:36:46 +0100
Message-ID: <031e616b-b080-4cfc-9c99-00df46b4075b@foss.st.com>
Date: Thu, 23 Nov 2023 18:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] iio: add new backend framework
To: <nuno.sa@analog.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand
	<frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_13,2023-11-22_01,2023-05-22_02

Hi Nuno,

On 11/21/23 11:20, Nuno Sa via B4 Relay wrote:
> Hi all,
> 
> This is a Framework to handle complex IIO aggregate devices.
> 
> The typical architecture is to have one device as the frontend device which
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).
> 
> The basic framework interface is pretty simple:
>   - Backends should register themselves with @devm_iio_backend_register()
>   - Frontend devices should get backends with @devm_iio_backend_get()
> 
> (typical provider - consumer stuff)
> 
> This is the result of the discussions in [1] and [2]. In short, both ADI
> and STM wanted some way to control/get configurations from a kind of
> IIO aggregate device. So discussions were made to have something that
> serves and can be used by everyone.
> 
> The main differences with the converter framework RFC [1]:
> 
> 1) Dropped the component framework. One can get more overview about
> the concerns on the references but the main reasons were:
>   * Relying on providing .remove() callbacks to be allowed to use device
>     managed functions. I was not even totally sure about the correctness
>     of it and in times where everyone tries to avoid that driver
>     callback, it could lead to some maintenance burden.
>   * Scalability issues. As mentioned in [2], to support backends defined
>     in FW child nodes was not so straightforward with the component
>     framework.
>   * Device links can already do some of the things that made me
>     try the component framework (eg: removing consumers on suppliers
>     unbind).
> 
> 2) Only support the minimal set of functionality to have the devices in
>     the same state as before using the backend framework. New features
>     will be added afterwards.
> 
> 3) Moved the API docs into the .c files.
> 
> 4) Moved the framework to the IIO top dir and renamed it to
>     industrialio-backend.c.
> 
> Also, as compared with the RFC in [2], I don't think there are that many
> similarities other than the filename. However, it should now be pretty
> straight for Olivier to build on top of it. Also to mention that I did
> grabbed patch 1 ("of: property: add device link support for
> io-backends") from that series and just did some minor changes:
> 

I did not already look at the framework patches in detail, but at first 
glance it looks fine.

I confirm that it has been quite straightforward to build on top of this 
framework, as it remains close to my first approach. I had only some 
small changes to do, to match the API, and to get it alive. This is great.

I see just one concern regarding ADC generic channel bindings support.
Here we have no devices associated to the channel sub-nodes. So, I 
cannot figure out we could use the devm_iio_backend_get() API, when 
looking for backend handle in channels sub-nodes. I have to think about it.

> 1) Renamed the property from "io-backend" to "io-backends".
> 2) No '#io-backend-cells' as it's not supported/needed by the framework
> (at least for now) .
> 
> Regarding the driver core patch
> ("driver: core: allow modifying device_links flags"), it is more like a
> RFC one. I'm not really sure if the current behavior isn't just
> expected/wanted. Since I could not really understand if it is or not
> (or why the different handling DL_FLAG_AUTOREMOVE_CONSUMER vs
> DL_FLAG_AUTOREMOVE_SUPPLIER), I'm sending out the patch.
> 
> Jonathan,
> 
> I also have some fixes and cleanups for the ad9467 driver. I added
> Fixes tags but I'm not sure if it's really worth it to backport them (given
> what we already discussed about these drivers). I'll leave that to you
> :).
> 
> I'm also not sure if I'm missing some tags (even though the series
> is frankly different from [2]).
> 
> Olivier,
> 
> If you want to be included as a Reviewer let me know and I'll happily do
> so in the next version.
> 

Yes, please add me as reviewer.
Thanks.
Olivier

> Also regarding the new IIO fw schemas. Should I send patches/PR to:
> 
> https://github.com/devicetree-org/dt-schema/
> 
> ? Or is there any other workflow for it?
> 
> [1]: https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan@foss.st.com/
> [2]: https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan@foss.st.com/
> 
> ---
> Nuno Sa (11):
>        driver: core: allow modifying device_links flags
>        iio: add the IIO backend framework
>        iio: adc: ad9467: fix reset gpio handling
>        iio: adc: ad9467: don't ignore error codes
>        iio: adc: ad9467: add mutex to struct ad9467_state
>        iio: adc: ad9467: fix scale setting
>        iio: adc: ad9467: use spi_get_device_match_data()
>        iio: adc: ad9467: use chip_info variables instead of array
>        iio: adc: ad9467: convert to backend framework
>        iio: adc: adi-axi-adc: convert to regmap
>        iio: adc: adi-axi-adc: move to backend framework
> 
> Olivier Moysan (1):
>        of: property: add device link support for io-backends
> 
>   MAINTAINERS                         |   7 +
>   drivers/base/core.c                 |  14 +-
>   drivers/iio/Kconfig                 |   5 +
>   drivers/iio/Makefile                |   1 +
>   drivers/iio/adc/Kconfig             |   3 +-
>   drivers/iio/adc/ad9467.c            | 382 +++++++++++++++++++++-----------
>   drivers/iio/adc/adi-axi-adc.c       | 429 +++++++-----------------------------
>   drivers/iio/industrialio-backend.c  | 302 +++++++++++++++++++++++++
>   drivers/of/property.c               |   2 +
>   include/linux/iio/adc/adi-axi-adc.h |   4 +
>   include/linux/iio/backend.h         |  58 +++++
>   11 files changed, 723 insertions(+), 484 deletions(-)
> 
> Thanks!
> - Nuno Sá
> 

