Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1F476F26
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 11:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhLPKut convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 05:50:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18774 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231342AbhLPKus (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 05:50:48 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG484u3011380;
        Thu, 16 Dec 2021 05:50:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cyrbx9unc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:50:43 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1BGAogm6002013
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Dec 2021 05:50:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 16 Dec
 2021 05:50:41 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::ec36:89cb:a387:866]) by
 ASHBMBX9.ad.analog.com ([fe80::ec36:89cb:a387:866%20]) with mapi id
 15.02.0986.014; Thu, 16 Dec 2021 05:50:41 -0500
From:   "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] iio: addac: ad74413r: fix off by one in
 ad74413r_parse_channel_config()
Thread-Topic: [PATCH] iio: addac: ad74413r: fix off by one in
 ad74413r_parse_channel_config()
Thread-Index: AQHX8aocIRdZz4+5JU61aWdGiBPok6w08gqw
Date:   Thu, 16 Dec 2021 10:50:41 +0000
Message-ID: <45dd874f40e54872b4c94e00eae814c4@analog.com>
References: <20211215115053.GE14552@kili>
In-Reply-To: <20211215115053.GE14552@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3RhbmlzbGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wMjNiYzgwZi01ZTVlLTExZWMtYjZjZi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcMDIzYmM4MTEtNWU1ZS0xMWVjLWI2Y2YtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxODQ2IiB0PSIxMzI4NDEyNTQ0MDky?=
 =?us-ascii?Q?MDUyMzQiIGg9IlZYOXpDcmFpSERKMjI5YlJhMVNmRDkra2xaWT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RHk5WlBFYXZMWEFZWHFyTTVTNDIzQWhlcXN6bExqYmNBREFBQUFBQUFBQUFB?=
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
X-Proofpoint-GUID: yAw_Ca8mR1fgH-b-G3mHZid8yV6nvcuZ
X-Proofpoint-ORIG-GUID: yAw_Ca8mR1fgH-b-G3mHZid8yV6nvcuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160061
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, December 15, 2021 1:51 PM
> To: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan
> Cameron <jic23@kernel.org>; Linus Walleij <linus.walleij@linaro.org>; linux-
> iio@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] iio: addac: ad74413r: fix off by one in
> ad74413r_parse_channel_config()
> 
> [External]
> 
> The > needs to be >= to prevent accessing one element beyond the end of
> the st->channel_configs[] array.
> 
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Obligatory grumble:  When you merge a new driver please use a patch
> prefix based on what the driver will use.
> 
>  Bad: [SUBJECT] subsystem: add new driver for XYZ123
> Good: [SUBJECT] subsystem/xyz123: add new driver for XYZ123
> 
> Same rule for adding subdirectories.  That way no one (me) has to guess.
> 
>  drivers/iio/addac/ad74413r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index cbd9aa9b399a..289d254943e1 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1150,7 +1150,7 @@ static int ad74413r_parse_channel_config(struct
> iio_dev *indio_dev,
>  		return ret;
>  	}
> 
> -	if (index > AD74413R_CHANNEL_MAX) {
> +	if (index >= AD74413R_CHANNEL_MAX) {
>  		dev_err(st->dev, "Channel index %u is too large\n", index);
>  		return -EINVAL;
>  	}
> --
> 2.20.1

