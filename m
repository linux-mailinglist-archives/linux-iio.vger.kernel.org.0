Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C190348DFFE
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jan 2022 22:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiAMV5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 13 Jan 2022 16:57:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5638 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232985AbiAMV5r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2022 16:57:47 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DKUdsR027614;
        Thu, 13 Jan 2022 16:57:26 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dj0k5vjcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 16:57:25 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20DLse1P009765;
        Thu, 13 Jan 2022 16:57:25 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dj0k5vjcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 16:57:25 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20DLvNZT041894
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jan 2022 16:57:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 13 Jan
 2022 16:57:22 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::5d54:bde3:ae3a:70bb]) by
 ASHBMBX9.ad.analog.com ([fe80::5d54:bde3:ae3a:70bb%20]) with mapi id
 15.02.0986.014; Thu, 13 Jan 2022 16:57:22 -0500
From:   "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
To:     Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] iio: addac: ad74413r: Do not reference negative array
 offsets
Thread-Topic: [PATCH v2] iio: addac: ad74413r: Do not reference negative array
 offsets
Thread-Index: AQHYB/PhZsR0gqWiSk2h2Z3Z9M1zDqxhgPYg
Date:   Thu, 13 Jan 2022 21:57:22 +0000
Message-ID: <8e6a081daeb54be38fdd658c796ec120@analog.com>
References: <20220112203456.3950884-1-keescook@chromium.org>
In-Reply-To: <20220112203456.3950884-1-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3RhbmlzbGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1jNzkwNDViNi03NGJiLTExZWMtYjZkNS00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcYzc5MDQ1YjgtNzRiYi0xMWVjLWI2ZDUtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzMzAwIiB0PSIxMzI4NjU4NDY0MDc2?=
 =?us-ascii?Q?MjkyMjciIGg9IlNSTHM4N0wyQksrZk5aOERuYmFtbVpMSUlTVT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q3JpZWlKeUFqWUFlOStWYi9VQTRWTDczNVZ2OVFEaFVzREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
x-originating-ip: [10.32.224.39]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: WVOoT-p8GNM3EipZlYpV3JAPzINjmD0q
X-Proofpoint-ORIG-GUID: woJTYeWF4q6t1m8UWy_euaXCo5cicPKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130135
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Wednesday, January 12, 2022 10:35 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Kees Cook <keescook@chromium.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> linux-iio@vger.kernel.org; Tanislav, Cosmin <Cosmin.Tanislav@analog.com>;
> Jonathan Cameron <Jonathan.Cameron@huawei.com>; Linus Walleij
> <linus.walleij@linaro.org>; linux-kernel@vger.kernel.org; linux-
> hardening@vger.kernel.org
> Subject: [PATCH v2] iio: addac: ad74413r: Do not reference negative array
> offsets
> 
> [External]
> 
> Instead of aiming rx_buf at an invalid array-boundary-crossing location,
> just skip the first increment. Seen when building with -Warray-bounds:
> 
> drivers/iio/addac/ad74413r.c: In function 'ad74413r_update_scan_mode':
> drivers/iio/addac/ad74413r.c:843:22: warning: array subscript -4 is below
> array bounds of 'u8[16]' { aka 'unsigned char[16]'} [-Warray-bounds]
>   843 |         u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 *
> AD74413R_FRAME_SIZE];
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/addac/ad74413r.c:84:20: note: while referencing 'rx_buf'
>    84 |                 u8 rx_buf[AD74413R_FRAME_SIZE *
> AD74413R_CHANNEL_MAX];
>       |                    ^~~~~~
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v1: https://urldefense.com/v3/__https://lore.kernel.org/linux-
> hardening/20220105180214.2435001-1-
> keescook@chromium.org/__;!!A3Ni8CS0y2Y!oWs0KcGPANFn-
> L0qJPZgP47AQIYpBXJxg5LHiLDFGa_-SI2DwmSMzjgl3ehyu-8JYPgq$
> v2:
>  - Update commit Subject prefix
>  - add Reviewed-by
> ---
>  drivers/iio/addac/ad74413r.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 5271073bb74e..aba9a643a4ca 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -840,7 +840,7 @@ static int ad74413r_update_scan_mode(struct iio_dev
> *indio_dev,
>  {
>  	struct ad74413r_state *st = iio_priv(indio_dev);
>  	struct spi_transfer *xfer = st->adc_samples_xfer;
> -	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 *
> AD74413R_FRAME_SIZE];
> +	u8 *rx_buf = st->adc_samples_buf.rx_buf;
>  	u8 *tx_buf = st->adc_samples_tx_buf;
>  	unsigned int channel;
>  	int ret = -EINVAL;
> @@ -894,9 +894,10 @@ static int ad74413r_update_scan_mode(struct
> iio_dev *indio_dev,
> 
>  		spi_message_add_tail(xfer, &st->adc_samples_msg);
> 
> -		xfer++;
>  		tx_buf += AD74413R_FRAME_SIZE;
> -		rx_buf += AD74413R_FRAME_SIZE;
> +		if (xfer != st->adc_samples_xfer)
> +			rx_buf += AD74413R_FRAME_SIZE;
> +		xfer++;
>  	}
> 
>  	xfer->rx_buf = rx_buf;
> --
> 2.30.2

