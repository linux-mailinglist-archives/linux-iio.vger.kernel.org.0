Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945E62B405C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 11:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKPJ7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 04:59:19 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:38978 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgKPJ7S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2020 04:59:18 -0500
X-Greylist: delayed 2023 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 04:59:17 EST
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AG9Ocsw007228;
        Mon, 16 Nov 2020 01:25:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=zZzYd+0pnelnvyf52A5knBWbi4wGINCM2e9FYi+njDA=;
 b=s87stTpnTosX6x+xqNgCK+kLKvPLPD+56cof33BHu/7MdedUeVT8HRniomPzKySAoo1Z
 anmxDnTAel5d4p2txwRQZSuWqqBTLWz/2Q2DmHrxve/k9eMzAHyY9t54U3nvwTK3YFA5
 YntRGHriGZCGL2q//qVOD00FrCDAe5gdlXR7es/2Vym+cA0q7SuQr8HYrRnbf/vaLw8I
 0pRErXx/RVEcuuEAouZanB3fwQwo/FP873+XTOD5ZwhiCL4mWfNGKeXzgIsc+0Pp5Uoe
 QEwmuDbYEWompvat17DDAYTyjyzVv5w9OtbbgWNY4ltfK+rVf18qBMcU+nflN0DxI+ji wQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00328301.pphosted.com with ESMTP id 34tbksrmjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 01:25:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN/DKvHyQUOyG7M7Crv5nuInbjq8BHDZgvzgqYAmmE36wm2/t9Y3VblEhKVZ8NXduHYvJXnZmCyASeV/tmA04zlK3xyPfhnkiCtQwvZ0HmhiXE5CQIYHmXOj+Y1J7/kb6cgBApvQ2shw4ybVqD0JAZ5ikNK3iDL2rTE1e/XDIDMnWex2WdcVTHeU+WFh4VeQXZpcApcL73+DFdkS9XxuloGQlmgyEI3lE2MC4VpkiwV76ppFRkPHsiy8eC/lyw4FeAO6ZKcIYxR5GH+m2YXqvI355LhfcQ28lIaXCcF2B2kMtXRwgEA4axwvh+kBChi262EwqEGsOU4/zppZFK0hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZzYd+0pnelnvyf52A5knBWbi4wGINCM2e9FYi+njDA=;
 b=FkYyTizu2/Ru8uRJ3QHoP0eDbxnWm6bDsGj8FLYEYL2aWhSKoe3NJtePWKkPjPzIsyJBY0BIpkf/xBT3awySahQbfJr+B0vJex3Z3Zkl6VP04XL+vMI3ZhsMnBpye7zytkWFlkzbe2F3Hgx2ZjD3Xt2fXu1oklIzA/JlWwZ+l3mfLmJsX45Ep1+5g/7C7z0R0TOcQ6OWJJ28n46o+4Zq5fxLlQQ/dpw1kz+ruHXu3QFLodjtYSJwo+D2rgg2gnP1Ha26zV9Cf/fxAQU7+VuhbbhuiKflD3YRotsa9fIDQIVNK3qdjIv5rCmSgvnXm2hk3Zfl38rjez2IU5FxMawA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZzYd+0pnelnvyf52A5knBWbi4wGINCM2e9FYi+njDA=;
 b=h5l0Fg11S39fUWW2kIkeYfXkRuEvNUQC8lI5/cTVJnfYloAjp2EvXvDmNfQSrYjAuHeOEOO2K0pyQjJq1cSodV7emodPEav8BYNzQpZyRRvGiGIm6CWdBn0dTfEdcHrp6OouJvG/t4IMJ5JnAQbpjmXUzUW/JvENTdBMAvJS/pQ=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 16 Nov
 2020 09:25:26 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::c4d3:1f4e:6198:ce6f]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::c4d3:1f4e:6198:ce6f%4]) with mapi id 15.20.3541.028; Mon, 16 Nov 2020
 09:25:26 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/13] Documentation: ABI: add specific icm42600
 documentation
Thread-Topic: [PATCH v4 08/13] Documentation: ABI: add specific icm42600
 documentation
Thread-Index: AQHWSKsgRJzyGbHlXkO1VgJbvsWR6KnIor8AgALAXHA=
Date:   Mon, 16 Nov 2020 09:25:26 +0000
Message-ID: <BL0PR12MB5011F8499380AAF4D19DC88DC4E30@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
        <20200622153729.12702-9-jmaneyrol@invensense.com>,<20201114152302.3b05c4ea@archlinux>
In-Reply-To: <20201114152302.3b05c4ea@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:99eb:6b53:697d:27b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1027e10-4ab5-43d3-8d56-08d88a118d68
x-ms-traffictypediagnostic: MN2PR12MB3664:
x-microsoft-antispam-prvs: <MN2PR12MB36647EB54D81DF3887C629D1C4E30@MN2PR12MB3664.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JN9j5qarVg29tjbVBV5cmuHw2dl+tgmWWhSou62ei+9k/xYARSGfaqkt6DWmTx2P1WvmK4hpUGw3YoUhTZXW/Zfar/YK9ynLkl2qMF468jdK2OlSZeGzKN4ZWdwyBTSsKSkEyx0GPr/fWiO3YNIKvjerOo1c0eE7kVK/HJUMW6Nj770bS+WB6JdF0TqAACK/gKKrBRdKQSQi+jRtyZfpyLQBCwBTbMjpFve1egk759k8iRCMz0CxgfPdhHJVmKH07N1dZZs/tVQWo2zgEb9yOajlNL1lY21CLVDkn9BcGsP70tNqIxHjcDEWmBtAaXqrys678zx6kvayDXbb0/wQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39850400004)(346002)(376002)(396003)(66946007)(66556008)(64756008)(91956017)(76116006)(52536014)(66476007)(86362001)(55016002)(8676002)(4326008)(316002)(66446008)(5660300002)(8936002)(6916009)(33656002)(478600001)(71200400001)(7696005)(186003)(54906003)(6506007)(53546011)(2906002)(9686003)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KzK//OOHQ9e6uzyUPe/PcmhzIjNZRyxtZASn7LI9KP0RzDP89kMvbOZplV?=
 =?iso-8859-1?Q?3FPKlfNN7TNUdxQSVj2XDbbYxxLTB+ZLW4gV5zgC60qvR7dirnFTvwjgy1?=
 =?iso-8859-1?Q?/fpG21IBwnt2RY+5P02hABTSwZIpOW5cNB1+GUHpXGQyxMZcmyX+Lg7bwP?=
 =?iso-8859-1?Q?4FAUAFcDy0X2RB51+Y/s0IaGGTg1tqw83Vp/4iEi6dEDO3aDMMsLiBv3yz?=
 =?iso-8859-1?Q?4SoTdgSHgSmczSdIPa3KB3fJlJ8UbE/CQVkj176wY3NmfmYnUHToH2QDa+?=
 =?iso-8859-1?Q?i9fwcKIaRHoHRi+8+Xlg4t61jfB5HziH9Gt4/zMJufcMich1gcM34bqOEs?=
 =?iso-8859-1?Q?lW+pL7aRNAet8fwLz1L5mPg5zFupJh1WrqVLFjA9AC7e4sjImo0mLodSkH?=
 =?iso-8859-1?Q?71fk9VF7slMqHlAypWB/CJQOE/AyExduXpCNVY6vGnU4M4Uumes0KGsagf?=
 =?iso-8859-1?Q?YzAvx0qP9IDeyg8PbRqQqPEAhmpcbcSC9fWT/7z7dJj0E+cH6hWsxgXWe2?=
 =?iso-8859-1?Q?Q55Hc+/Rqu+NrzyoGyYyh7g3VG4CV+XIdl6nGVEjEvhY4IZ0qrQVA8hS3A?=
 =?iso-8859-1?Q?MuNmREgFIoJlkNlGRg08nGMyIeIAEjrgMsNaQKA7vknxMMKWuSIPwi1Leu?=
 =?iso-8859-1?Q?ONBoBJx7NwzjSUVytQRRMzolsTRWqBoOI0CM1sjVLQJqqPMg05u8ry1bDj?=
 =?iso-8859-1?Q?ArrfZWD/cQfbhJjYq8smHA/Ydymj7vp+F6aBYAqigSJgftkQnjbUdUgJ+w?=
 =?iso-8859-1?Q?ivXgPg+JiwJl7mfE3nHP3rezqCTI2qpB2mVAhcdqDapc9nZ9spoNsethrI?=
 =?iso-8859-1?Q?2Xohje33+BXwRCRFvvO1JTxX2JuibeMPLMQ50rjAoT2VHgXkMhR8v9rPMT?=
 =?iso-8859-1?Q?vnbF8w0L/1WW1eQUMrdWjbhyLitgWNCzNX3vcgZN7wfXj/QMjNDeXDApDL?=
 =?iso-8859-1?Q?lRRtGs8GJbWrD8P5QJRJ0M8al9yOvfO8J4Zm4EQcyc1RyXjCIm7Ceg=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1027e10-4ab5-43d3-8d56-08d88a118d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 09:25:26.3943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8puLAupI1/8pF2DCkjtYSgfGdOPpq5a7gjaepOMEfIwAo+C+yf9a1JHcBTkTbBp3uq/7X8R3EYbRVkXsK5mlystqqSXMW/MPdXdwM0jZHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_03:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
no problem for me, you can move it wherever you see fit.=0A=
=0A=
Thank you.=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, November 14, 2020 16:23=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel.o=
rg>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemloft=
.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree=
@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject: Re: [PATCH v4 08/13] Documentation: ABI: add specific icm42600 doc=
umentation =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Mon, 22 Jun 2020 17:37:24 +0200=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
> Hardware offset available as calibscale sysfs attributes are real=0A=
> physical values exprimed in SI units.=0A=
> =0A=
> calibscale_available sysfs attributes represents the range of=0A=
> acceptable values.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Hi Jean-Baptiste. =0A=
=0A=
This is causing us some issues as the ABI docs are now added to the=0A=
generated html docs for the kernel.=A0 It's been a while, so I've kind=0A=
of forgotten why we have this file.=A0 Was the issue that these are=0A=
in SI units as opposed to most calibbias controls which are offsets=0A=
applied to the raw analog reading hitting the ADC?=0A=
=0A=
Would you mind if we moved this into the main doc as a note for this=0A=
particular device?=0A=
=0A=
i.e. something in sysfs-bus-iio saying=0A=
=0A=
icm42600: Hardware applied calibration offset is in SI units (rad/s or m/s^=
2 as appropriate)=0A=
=0A=
?=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=A0=0A=
> ---=0A=
>=A0 .../ABI/testing/sysfs-bus-iio-icm42600=A0=A0=A0=A0=A0=A0=A0 | 20 +++++=
++++++++++++++=0A=
>=A0 1 file changed, 20 insertions(+)=0A=
>=A0 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600=0A=
> =0A=
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documenta=
tion/ABI/testing/sysfs-bus-iio-icm42600=0A=
> new file mode 100644=0A=
> index 000000000000..0bf1fd4f5bf1=0A=
> --- /dev/null=0A=
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-icm42600=0A=
> @@ -0,0 +1,20 @@=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_accel_x_calibbias=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_accel_y_calibbias=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_accel_z_calibbias=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_anglvel_x_calibbias=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_anglvel_y_calibbias=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_anglvel_z_calibbias=0A=
> +KernelVersion:=A0 5.8=0A=
> +Contact:=A0=A0=A0=A0=A0=A0=A0 linux-iio@vger.kernel.org=0A=
> +Description:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Hardware applied calibration offset=
 (assumed to fix production=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inaccuracies). Values represent a r=
eal physical offset expressed=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in SI units (m/s^2 for acceleromete=
r and rad/s for gyroscope).=0A=
> +=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_accel_calibbias_available=0A=
> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/bus/iio/devices/=
iio:deviceX/in_anglvel_calibbias_available=0A=
> +KernelVersion:=A0 5.8=0A=
> +Contact:=A0=A0=A0=A0=A0=A0=A0 linux-iio@vger.kernel.org=0A=
> +Description:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Range of available values for hardw=
are offset. Values in SI=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 units (m/s^2 for accelerometer and =
rad/s for gyroscope).=0A=
