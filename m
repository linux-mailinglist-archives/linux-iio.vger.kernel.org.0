Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3AC550182
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 03:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383450AbiFRBBx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 21:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiFRBBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 21:01:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A66AA5F
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655514110; x=1687050110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zR1gSwxkzYD6bd2puOA+3X8pOo/RX1o1swKt46JkSKw=;
  b=CuQKEMOiqZMJF0aJntypENY4vxvTbcbr/++4UD9KPA6+HMjsm+CBeZew
   ljE/CbWHEDJW2A7aavL5eByBCLoZoPYBsQji2FUCGSb9hHLCMQ2BkDhw1
   7JVtHZaAdjxDdn9MLMmnN5IF0kgPcsM1hKVs10GI/07Ul444iAQe0wn4J
   Doy72niLE3DnO4XDqrZvWPK9NKgnBTxyX5Ki+44qz76m1TxSN/kq9GZaY
   78pfcQMFQrRR1h3XBC/gB/x+TrPpjvJPpKp/DMfD+d7S8WwpZDP4/ax8S
   lpgbA9Z+6CceFJn8LwbBWcdBdFQVWVMLOFLSgRDKixa5LAwxu1YjMKM4X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343607245"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343607245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="537009760"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 18:01:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 18:01:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 18:01:47 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2308.027;
 Fri, 17 Jun 2022 18:01:47 -0700
From:   "Hall, Christopher S" <christopher.s.hall@intel.com>
To:     "N, Pandith" <pandith.n@intel.com>,
        "william.gray@linaro.org" <william.gray@linaro.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Topic: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Index: AdiCFGKgSJf28KGeQ2qEKrwEQy9pwAAd/EBQ
Date:   Sat, 18 Jun 2022 01:01:47 +0000
Message-ID: <ff67454b89fa444db36dee57fac5eb74@intel.com>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

N, Pandith <pandith.n@intel.com> wrote:
> Hi,
>=20
> We have a Intel Timed IO peripheral with following functionalities :
>=20
> 1. Event capture capability - Captures event count and timestamp.

An event is an edge on the input or output signal. Rising, falling,
or both edges can be selected for counting / timestamping. The
timestamp and count are captured synchronously.

If, for example, the hardware is configured to capture both types of
input edges, each input edge causes the count to increment by one and
the ART value (see below) to be captured atomically.

To see how this may be useful, consider the case where two event
occur before software is able to read the first. A count delta of >1
indicates that an event timestamp was missed.

For another example: If the input signal is periodic, the frequency
offset between the input clock and the local clock can be computed:

 (delta ART / delta count) * (nom. input freq / 1e9 ns) *
	(1e9 / ART frequency)

It is not necessary to read each event to determine the average
frequency for multiple events.

> 2. Pulse generation - periodic or single event generation.
> 3. Return cross-timestamp on request.

This may imply that the Timed I/O logic is driven by a separate device cloc=
k.
It is not. It is driven by the platform clock - the Always Running
Timer (ART). ART is directly related to the CPU timestamp counter (TSC).
ART and TSC can be converted to one another using the following equation:

TSC_Value =3D (ART_Value * CPUID.15H:EBX[31:0] )/ CPUID.15H:EAX[31:0] + K

ART ticks at the core crystal frequency. Typically this is 38.4 MHz. The
frequency can be discovered by reading CPUID.15H:ECX[31:0].

More information can be found in the Intel Software Developer's
Manual (SDM) in the Invariant Timekeeping section
17.17.4 and Determining the Processor Base Frequency section 18.7.3
(https://cdrdv2.intel.com/v1/dl/getContent/671200)

K is typically zero. A virtualized guest is an example where K !=3D 0. In
this case, K is offset by the value of the VMCS TSC offset.

An example of how ART can be directly converted to system time is in the
e1000e driver:

drivers/net/ethernet/intel/e1000e/ptp.c:e1000e_phc_getcrosststamp()

using the following functions:

- arch/x86/kernel/tsc.c:convert_art_to_tsc() [ART->TSC]
- kernel/time/timekeeping.c:get_device_system_crosststamp() [TSC->System Ti=
me]

These are dependent upon TSC being selected as the clocksource. The
attempted conversion results in an error otherwise.

A PHC driver implementation of Timed I/O was proposed:
- https://lkml.org/lkml/2020/1/31/25

that included a cross-timestamp function. This crosstimestamp - in the sens=
e
of determining the relationship between two independent clocks - is a
software fiction because system time is based on ART. The cross-timestamp
value enabled conversion of an event timestamp from ART -> System Time in
the application in the usual way when using the PHC API.

In my opinion, given a (more) greenfield API implementation. ART timestamps
should not be exposed at the application level at all. All timestamps
returned to the application should be in terms of system time.

There is a chapter (21.3.5) in the Atom(r) x6000E datasheet for Timed I/O:

https://cdrdv2.intel.com/v1/dl/getContent/636112?explicitVersion=3Dtrue&wap=
kw=3DEHL%20datasheet

Note that the hardware function is called TGPIO.

There is also Timed I/O example code using the PHC driver referenced above:

https://www.intel.com/content/www/us/en/develop/documentation/tcc-tools-202=
1-2-developer-guide/top/time-synchronization-and-communication-tools/time-a=
ware-gpio-tgpio-samples.html

Thanks,
Christopher
