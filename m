Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A934C647F85
	for <lists+linux-iio@lfdr.de>; Fri,  9 Dec 2022 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLIIrJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 9 Dec 2022 03:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIIrI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2022 03:47:08 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42C059168
        for <linux-iio@vger.kernel.org>; Fri,  9 Dec 2022 00:47:06 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B96iLHn018071;
        Fri, 9 Dec 2022 03:46:43 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mbe0c8sur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 03:46:42 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2B98kf61017833
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Dec 2022 03:46:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Dec 2022
 03:46:40 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::9083:aac7:eb90:8b4]) by
 ASHBMBX9.ad.analog.com ([fe80::9083:aac7:eb90:8b4%20]) with mapi id
 15.02.0986.014; Fri, 9 Dec 2022 03:46:40 -0500
From:   "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [POC] iio: ad74413: allow channel configuration to be given via
 module parameters
Thread-Topic: [POC] iio: ad74413: allow channel configuration to be given via
 module parameters
Thread-Index: AQHZCwnEse8Q6L4NukqA4eUk/f5DlK5lPrUg
Date:   Fri, 9 Dec 2022 08:46:40 +0000
Message-ID: <57e440708c1946c9a309346cc7636fe0@analog.com>
References: <0833ed443220263ce068f5faec33fdef4435226a.camel@gmail.com>
 <20221208133354.2980343-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20221208133354.2980343-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3RhbmlzbG?=
 =?iso-8859-1?Q?FcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1mZGYwNDIxYS03NzlkLTExZWQtYjZjYi?=
 =?iso-8859-1?Q?00MTU2NDUwMDAwMzBcYW1lLXRlc3RcZmRmMDQyMWMtNzc5ZC0xMWVkLWI2?=
 =?iso-8859-1?Q?Y2ItNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIyODQwIiB0PSIxMzMxNT?=
 =?iso-8859-1?Q?A0OTE5ODI3Njc4MDgiIGg9Ilk1UTYraC81Vjd4TG9mUEl5YUtiTU1xMTJx?=
 =?iso-8859-1?Q?ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBREFKazNBcWd2WkFmTTd2citEWjJTNjh6dSt2NE5uWkxv?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-originating-ip: [10.32.224.84]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: GaEB4khDsWc5QpLr41Gv91ddM7Br8Yxa
X-Proofpoint-ORIG-GUID: GaEB4khDsWc5QpLr41Gv91ddM7Br8Yxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_04,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Sent: Thursday, December 8, 2022 3:34 PM
> To: Nuno Sá <noname.nuno@gmail.com>; linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>; Tanislav, Cosmin
> <Cosmin.Tanislav@analog.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Subject: [POC] iio: ad74413: allow channel configuration to be given via
> module parameters
> 
> [External]
> 
> Just to see how it would look, I tried doing the below. Since a board
> may have more than one ad74412/ad74413, one needs to be able to
> differentiate between them. So for now each module parameter channelX
> (X=0,1,2,3) accepts a space-separated list of <label>:<function>,
> where label is matched against the label property in device tree, but
> also allowing * to match any, which is more convenient when one knows
> there is only one device.
> 
> Aside from the missing documentation (MODULE_PARM_DESC), there are of
> course various details to hash out. E.g., should the function be
> specified with a raw integer as here, or should we take a text string
> "voltage-output", "current-input-ext-power" etc. and translate those?
> Should we use space or comma or semicolon as separator? And so on.
> 
> I also considered whether instead of the label one should instead
> match on the OF_FULLNAME,
> e.g. /soc@0/bus@30800000/spi@30840000/ad74412r@0, but that's a lot
> more complicated, and I assume that anybody that has more than one of
> these chips would anyway assign a label so that they can distinguish
> their /sys/bus/iio/... directories.
> 
> I should also note that it is not unprecedented for modules to take
> parameters that do some sort of (ad hoc) parsing to apply settings
> per-device. For example:
> 
> - ignore_wake in drivers/gpio/gpiolib-acpi.c
> - mtdparts in drivers/mtd/parsers/cmdlinepart.c
> - pci_devs_to_hide in drivers/xen/xen-pciback/pci_stub.c
> - quirks in drivers/hid/usbhid/hid-core.c
> 
> So the question is, is there any chance that anything like this could
> be accepted? If so, I'll of course spin this into a real patch with
> proper MODULE_PARM_DESC and commit log etc.
> 
> This has been tested doing
> 
>   insmod ad74413r.ko 'channel0=*:1' 'channel1=*:3' 'channel2=*:2'
> 'channel3=*:4'
> 
> and seeing that the channels did indeed come up as expected, where the
> device tree specified CH_FUNC_HIGH_IMPEDANCE for all of them.
> 

Nuno previously mentioned dynamically loading device tree overlays,
which seems like a much cleaner solution to me. Have you looked into
that?

