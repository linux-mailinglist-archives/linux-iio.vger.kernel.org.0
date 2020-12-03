Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85B2CCDBB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 05:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgLCEHg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 23:07:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbgLCEHg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 23:07:36 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B342rCx012387;
        Thu, 3 Dec 2020 05:06:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=CbripCPJljOl/0olmujubmS1oPh0veJLauFA3DAc6zs=;
 b=mYBi6libaTr6PDcoZMxAlPY/cCA3fm4Tc0kSla/NqPbfqLndrh0dI8I9ewl/rvnSNTya
 SteF59OfOzVOvekr5AbugrTRkiyJSr3zP1SnE/LACo6AQyzdt8kbjV4hv+VaPBp7LOgU
 ULSJxw8C7+PSDalfHgX6hfAwGDeWq6Sdw2Ch6IV48igKkA1fol3qVW0KIXQKfipEp6eK
 xoKWf5Y1lfOyHShcL6p9ug2oJ9ogjpnMlXIcrdIbEslMq/McNCbmA36T+sUUVr2K9RuV
 TDQpFYUt5iJRAoEWWg7T03X7K4D7ok9ewWY8qJg3FE/BW4S99pXGLH/N5sUPhH2a47IA NQ== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
        by mx07-00178001.pphosted.com with ESMTP id 355w3cf09k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 05:06:47 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw6+vO97beALI/bCJyXmUWeTqfe97iUOjyCNpz1MvhtxaQ3tGoW3EBNv9e4BcS7i12Q4Y7ThiaYGtgE8vbsgdeWMvnAZp7m2hqxRWCUvNdP46F5Y5mQni4jjVXi+gNkVK377YpqdSStWz2imvDh03O3YlLP8KP3fMgVVqohnFy8IqTL83Q9Q2eKqvr4QbzDByqzRUnOSv20bHW/9aRdKbJgXSnN7WUbOPO6DFhDArUgZuPehTw896vbPqTEls6E4Xu7MfMXQvvZ6d40bjPsUfPQ/4M9G7tisbR34ugvdmyu4yZdDiOTiUluMcQQnfdvNiGcm/QPzUIFG49xUYfiaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbripCPJljOl/0olmujubmS1oPh0veJLauFA3DAc6zs=;
 b=G0n4LmCRsEYympzEqfK4pX8T48miR01KuIT1ddALxXkp1EyTVbxHD7IsPNXANXl0tEdXhJg7bZMHrKCX3ZzgXhLgsZIwL2IHcNrqHrbY/szsPPe3YjG6NBYS/sW6JWIGTJhLQgOTev1vXQ62mVKSRl74uPEZmBC8ttXmhyL4qrJCd/AGIzUPr6kfkoZuhLQL8OKOCa0yYCUYe+ZVilenE/vJ9zsc288GkW0TwtN0gdBA5YBPl83ZppDki1JKMzCRhwxWkqDWODeClSAw4iZGsFm03iypo8Hlrq+MPlfj8OLlZ8wRZyKR4cZ+3ORqy7WNXQdVAgBvqz4iVotKjNnF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::21)
 by AM0PR10MB2739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:133::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 04:06:45 +0000
Received: from AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4bb:187f:c55a:8d09]) by AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4bb:187f:c55a:8d09%7]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 04:06:45 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: common: st_sensors: fix possible infinite loop in
 st_sensors_irq_thread
Thread-Topic: [PATCH] iio: common: st_sensors: fix possible infinite loop in
 st_sensors_irq_thread
Thread-Index: AQHWu10HCB3BwS9oOEW2x8iX9qw3vank1OFA
Date:   Thu, 3 Dec 2020 04:06:44 +0000
Message-ID: <AM8PR10MB4209021B3239B1CE06D2824DEDF20@AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM>
References: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
In-Reply-To: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=st.com;
x-originating-ip: [104.129.192.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d600ac44-d500-4b33-6236-08d89740d933
x-ms-traffictypediagnostic: AM0PR10MB2739:
x-microsoft-antispam-prvs: <AM0PR10MB2739BD4240658B063E5DEE23EDF20@AM0PR10MB2739.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmRG9HfOAfIdclzULWjRnPoWyThPim1aFkMyKPC8SnVl4rcjCq6tdYAbbcP8/+U5cJlJL304oFmaq6RbnRrrG/rEdvVC7BTL/swkUKh/VXHdzq/Pibc1kD3EJpJ9oAUiF0CLlzSI1AvxHMbyqfB+zxTUDpH9i3O4avTo47vDlx7wQCmmesflxD+V5zeMNyO1ya8EuO2Weozwsb81kSUz5E+T1ewk3sBWYFYCLWOkl8muH9VEMy96tBW0NcsdjXKUqFBs3kKmxmqRTonlnHDdQTg5GJMhZjpNfYG45l28+QjRQRQwFVecX9xcKHh2nkDpCE15sIanmcjqcqFgV9vCxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(8676002)(33656002)(83380400001)(9686003)(8936002)(55016002)(4326008)(2906002)(6506007)(52536014)(55236004)(26005)(53546011)(7696005)(66946007)(66556008)(66476007)(66446008)(76116006)(5660300002)(64756008)(186003)(71200400001)(110136005)(54906003)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Zm+YYPu1goPucuE3k8xE3yzpWznROjqBH/L8LxZ12dhDyTTuqIClR459RtaD?=
 =?us-ascii?Q?aKX4P7H/lF0Z9GilcjaQgjpmDBQ/LyXCVUHOQQS70ACABuBO2JSOEsS+MdQP?=
 =?us-ascii?Q?FJBeBLkL/SDkU2lcyGRrD0CwNoATlGf4SDOwCYrL2uFHJhJPDBqejgyX69YT?=
 =?us-ascii?Q?PDLC10H/MNzSox04By4vlGnxxEDyIZ/TSxIFfez42VTpU+qjyj8a79wYpid3?=
 =?us-ascii?Q?UgiohQ+wS1N102vggfgsi1+8yp+A5PwNV/s3Lny6g0vESpNmbJVd7U/ZqrKo?=
 =?us-ascii?Q?aNfvD4c89Qo7rFglZG5c0X6owBZCx9UXrv+T4ElsFHcR1vpTrVDHmeSsd97C?=
 =?us-ascii?Q?tHsRSMBGWCFnm8EPBknZD2QfgeEW6imiIgE5X9VKCCTEMrQp9DXzDB3n4iKU?=
 =?us-ascii?Q?qQmhx8/z9yn3+SLAGTt2SiXZllw1In/5ZlWZkzbPi2tpx8JTe46Ve5YEkRwH?=
 =?us-ascii?Q?dP9uquHkRmj4RIZQmq2AmmPXbpT/7CZNqECG/p4e7TdeC5jnO/ZH95wvj0CY?=
 =?us-ascii?Q?iHIP2MllLoyQJ0bsfZO0FHMPqmz7ZvT5Wxq1A2bOAl9AIre8UtIvbuld9OyX?=
 =?us-ascii?Q?IhytgsnZUWQKWRVdFjc9IT+gCDDLHPLNrLeIv8oha4TnRmY02Rof/rrHs/n4?=
 =?us-ascii?Q?3GnGOxwFjsHFo/hyQf+u/yIs9PyJGM7duEJS1V3OIHL/sCBN0sRjv/+dAZQD?=
 =?us-ascii?Q?EXfCnmnmEzNrQOLuk3TnXrHjS2J1u2tYAHq7JdDyuiU/jNs98FoU+iaBe3HI?=
 =?us-ascii?Q?Qmy6SITKI2RGEgagMdpIAiUwgzKgNCakh8SW9Rvh6ovL8IsMuywNyHZl2OYQ?=
 =?us-ascii?Q?K386ag6NWkdVuwF8pmLcOu3+6eUzYgWcjClRIVoC1yrhKtMKo0uRntF5Dafl?=
 =?us-ascii?Q?QUkFi3TZN74t+bEfcV2GeU7O7eOPNRnZiMeITPW0p1+5UqrTSTITSN6VlMFG?=
 =?us-ascii?Q?QPMiie7WZHuEtjdP/OrfKDMuDGY2cI+7VBifOT8G2c0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d600ac44-d500-4b33-6236-08d89740d933
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 04:06:44.9335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rXHnL9Uwo0y8gN0CkKdxzNFyC94y2L27F8jfwdv0cnHZDbnPrePs3ejyRhhDHAA5Sk8CPGRDUQc2vP0qGGJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2739
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030022
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Lorenzo,

I am not able to test it right now, I can probably do this weekend.
My comments inline.


> -----Original Message-----
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Sent: Sunday, November 15, 2020 6:38 AM
> To: jic23@kernel.org
> Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org;
> linus.walleij@linaro.org; Denis CIOCCA <denis.ciocca@st.com>
> Subject: [PATCH] iio: common: st_sensors: fix possible infinite loop in
> st_sensors_irq_thread
>=20
> Return a boolean value in st_sensors_new_samples_available routine in
> order to avoid an infinite loop in st_sensors_irq_thread if stat_drdy.add=
r is
> not defined or stat_drdy read fails
>=20
> Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> This patch is just compile tested, I have not carried out any run test
> ---
>  .../common/st_sensors/st_sensors_trigger.c    | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 0507283bd4c1..3bee5c9255d4 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -23,35 +23,31 @@
>   * @sdata: Sensor data.
>   *
>   * returns:
> - * 0 - no new samples available
> - * 1 - new samples available
> - * negative - error or unknown
> + * false - no new samples available or read error
> + * true - new samples available
>   */
> -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> -					    struct st_sensor_data *sdata)
> +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> +					     struct st_sensor_data *sdata)
>  {
>  	int ret, status;
>=20
>  	/* How would I know if I can't check it? */
>  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> -		return -EINVAL;
> +		return false;

To me this should return true. When a sensor does not specify the address (=
because there is no such register ie) the interrupt should be considered a =
valid interrupt.
In the original code from Linus indeed the if condition that is using this =
function is checking && -EINVAL that is considered true.

>=20
>  	/* No scan mask, no interrupt */
>  	if (!indio_dev->active_scan_mask)
> -		return 0;
> +		return false;
>=20
>  	ret =3D regmap_read(sdata->regmap,
>  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
>  			  &status);
>  	if (ret < 0) {
>  		dev_err(sdata->dev, "error checking samples available\n");
> -		return ret;
> +		return false;

This part indeed is probably the one that before could cause problems becau=
se in case of failure -something returned it is considered true.


>  	}
>=20
> -	if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> -		return 1;
> -
> -	return 0;
> +	return !!(status & sdata->sensor_settings-
> >drdy_irq.stat_drdy.mask);
>  }
>=20
>  /**
> --
> 2.26.2

