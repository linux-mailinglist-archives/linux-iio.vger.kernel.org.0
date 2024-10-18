Return-Path: <linux-iio+bounces-10723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C149A3DE7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 14:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664221C22E68
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F61BC49;
	Fri, 18 Oct 2024 12:09:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2138.outbound.protection.outlook.com [40.107.239.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56418028;
	Fri, 18 Oct 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253362; cv=fail; b=MJ4ck5yNAaF0VHeIdIbOQWWs+RvILbzVEkjLZ409vGyJO8zsZIxBFWKGqEVYh1dIl83PtMUTCcpgyI2jWWhNNZHUImDfkjVKglyBrGllP55yF9tFJqByFDIimPuwb6bBgVlL5m6IUjy3Ofx7aEGMhpxUAt8rT7idlPa+5vDV58A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253362; c=relaxed/simple;
	bh=DgI8lwtdab0ebhpTwrQrA9k/I3HQp2EdZLq/pyeO5xI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8wupzBRL5G2yBF6H51iN60m1vq8lxovE9UaFZ1k3XXv8rzQllN0djKhRT9Y0UOeMd3rdrt22u1NojPzYK/Zhjpd+fI5MyrOQtR1wvXvT+rjEkE8n0IarZz/Jk5QDPwp8mVUeB/ZTt5Rjn+ID0WxW4ywUCTEjg+x7TxpBvXCU+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azmG70pr7LbkDrM20cMU7HYkeh86gCK21QE9hJNOnleyx2Q79KmP/fKlEYKPWgeyOyxqYE+zm+7u6klLiG1XODgeGvkJr/JKokWoKyLMMs5gyQKjaWk6Dqz86uVYChkzulbn8E3JLcSRGbOe7YXQDUXdokjLuUkkDxflh+mIJS22X7zhFrkGXpGM9nhqTNTHeXLGsWO28zcsj+qKYU9kXvt7ghbuzfPQjyM6b3lytQqqA7R2Dlkei9I2h6xS+hfTsBg+A0BtNGsilMnIoQSZaBaFbX7i7PolV+QP97nbAdjgXolFL0IsYdQ9RVFc2UePxwX9UHmaUnbmlQwIFZmCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgI8lwtdab0ebhpTwrQrA9k/I3HQp2EdZLq/pyeO5xI=;
 b=k6KlFQrurQ2hOEhaLVpYIBeaNPyP0K2AXcBHI5ajzgplZ1oGDyJgx3f8EYBOxMAm2rvuC6hHvnfoIVjPWuZB9wyODdYIhxVkp/nH0khlr926rMJ6xHhz651Sk/u4hmBaEhQOyd4GHMrDYiCb6FoqLka0N+AJ3eHVqrjOWP0W1tKQl01JHQUkOJ3b96bB3TPkDkSEz9GUsMaS62HjxYtpCPjJ1V2TpPKEIkRzxK6EmNvJjGfok2y1213icrVA8abSkCX8l0QFwsW1mCi8EdGG7LgTUE+/zC0Pia8h3s3KxAp7IRypFQPVxu2B6i0Caqo8A12CnS9nN1UPFSH72Eursg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN1P287MB3578.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 12:09:14 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 12:09:14 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Thread-Topic: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Thread-Index: AQHbHuOXE0eB1lmnBEukSonJJXeKXrKKkz+AgAHZ0eE=
Date: Fri, 18 Oct 2024 12:09:14 +0000
Message-ID:
 <PN0P287MB28433EE5A3698E624F9BA2D8FF402@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
 <FR3P281MB1757A52E4202A0193543C1DBCE472@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <FR3P281MB1757A52E4202A0193543C1DBCE472@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN1P287MB3578:EE_
x-ms-office365-filtering-correlation-id: bded403d-4268-44dd-f2f9-08dcef6daec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?b+1wljd5n8GzAUEmxQhXxkrMaeqAuEx/tPZfM+b6H8PsfFxQGxEkOa7QhE?=
 =?iso-8859-1?Q?wOEzozBYy6h+I+qzDPppaLB1EZ1KrCRjscFJKFVkjpb07KHpXj9A4V7l5/?=
 =?iso-8859-1?Q?Gj9/uQWkGuRI1gucGDe2+V9YrYO7C4c1h2NrLbN9TDHAmmqJiUmsEC1Z2o?=
 =?iso-8859-1?Q?0RyemVlgi2+LrD9fSgWfzT+reAz1F4Y+5y53iqw2TIiWoVL5+EiwZtV+Q5?=
 =?iso-8859-1?Q?RthL8gP7HHtVAvjrbda0fOjIBkERfhIg1znsRIagq4WcaMZ/CX9+WO0sPp?=
 =?iso-8859-1?Q?GkcgJQCZ0xAvtyVS+tz7vAT/zvFuJKNTNotEB/h0ghI7hW31ljw3hcO730?=
 =?iso-8859-1?Q?v+MCap8GmlenbbZik+ZSxNF0wSTf6aheGBy8/q5/ofJkW9yMroDCWiRQWT?=
 =?iso-8859-1?Q?4B2teowgE1t4Hz5wXQ40HFSV+jsZOMvzVGV/vEjtAoRPEl+OBks312jlSL?=
 =?iso-8859-1?Q?on5No0muEJgjdBQ4dFVzJPycfjeKDM/f40xEHp8+1+RVAv15Q17kxr0CBx?=
 =?iso-8859-1?Q?5BC7acRUKUSddy/tQH6smsFXhUUsISdQWdjtrEmnk3OeM1S9QoZeFr0uen?=
 =?iso-8859-1?Q?NgMViwT/NZYWOV1J7gbCN6Hqj7PQ5IK8AADZJ9Ym6bqBp0QY4BFKZHrVXU?=
 =?iso-8859-1?Q?BMK5VYA8wcNqdMukUh5gGoq8lAQhCl8wH0c4353NVrNMAHgq03c4TlW33E?=
 =?iso-8859-1?Q?DeEKFCnEAN4Z3Tyye9wNq5qaPmqwt0bVYrVLNFaDkxdrOE9XAAKpnneMTJ?=
 =?iso-8859-1?Q?HTNymd+bZnrgvxkdJQKGV4ZEKCOzEtQSghq7Ns5Ru1sQpeHzrQx9QvcvVc?=
 =?iso-8859-1?Q?kvyOy0DrRe7etDpn32s6YZSx7+gGZVcmrdRME8QgRzQK6IcBRm2U/3m7/0?=
 =?iso-8859-1?Q?pSkXjQP0/Vyaf9Ij46okbhTO9YJgfjqF696yLyhCXtJG8+Hq9Jiid5q1ng?=
 =?iso-8859-1?Q?GBUBNdOuc9DoLcrEoI8iufzGJ/sVd7izxbt6S+u+Lnu+6VsOilF/O6mg0G?=
 =?iso-8859-1?Q?w8aCYN1ZZpxC0/fycMxbDw6IA4CwVYIGX90MZLOlOaCLRoALc+3kRv9bo8?=
 =?iso-8859-1?Q?lGFE1jzss8j963cjzPzUpXrYCF6SmnXBgTPimPkPN+AKpos3Xm389kHy0y?=
 =?iso-8859-1?Q?/3SZxcR3v0ehxMAMyobnbjKyaOsATPXQXrNSibT+Nx43mIx/ceD05pC0Wv?=
 =?iso-8859-1?Q?XahzEg/seE1pO8vRQW2lH5GV7fsjud69zQ4m1j9Eza/XHQ2OpppiZ/vGkD?=
 =?iso-8859-1?Q?NyyYZnSR819mTFb0ygiGsKENBFphNDGA+Icb7LTDvawwgk3PNR3RFfK07K?=
 =?iso-8859-1?Q?Nwh+VxuIMKMEishIhZGPhpNtF7dsPc1I0rbV+6vgHeGqEjpgCcUDm+Aff3?=
 =?iso-8859-1?Q?KY1lUFMLr9VDPIltlflu/3KbonK0C1ydQyuJljGmHiyXex9vI5gtXGg7yI?=
 =?iso-8859-1?Q?2izX7R4Y3pYDySWcyZlUgSxnUOJQcqSetKSHAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vkrniEwGT5aV0KznBQ5tYeM9o4+3S8lWBOclcJBNIIpGZSAprr2xC/9QEp?=
 =?iso-8859-1?Q?JN663frXKWCRYE8g3/XZBbf5efy54Zsv3qtwG32TS9hq0bPqsCqWIVCPCa?=
 =?iso-8859-1?Q?EC/kzeXlapp25+9nD4rHG3k9h0TAiHLMSiAgq8EMi6cFpn5WfnVVVPIuIh?=
 =?iso-8859-1?Q?1rXDRgjiii2sMMhFE4FVUrvmbWfFBhEXvNfASU+1DzK362cXch5CuQ4xgj?=
 =?iso-8859-1?Q?7fDgMtcmp0aFJmApdkjohTxrHrN5J8TxtaJGCCr34xQGqM0wQhhnpjv9Oh?=
 =?iso-8859-1?Q?t5v9hrBm5Uw4PfGLXjKc+4moD62s5ZpGywKxPUuOHU09F5ZnDbkslUJ8ti?=
 =?iso-8859-1?Q?AIgqdMWar6u8lqlJYUE9bHG0PtE4Hnhh/7cgcVlEQw1xb+TgzRykA58six?=
 =?iso-8859-1?Q?48TwOI/mjtYyH1DAoZdaY42qLhKKRFGtT8UHOQRH4wU0WVtKArY2frr/QV?=
 =?iso-8859-1?Q?ETawrEhi3A2ihNzbJX+mrqBfn4NUWAR2KR+1zUtxfmo4YNkWNJLPpWgWcW?=
 =?iso-8859-1?Q?ovczrkm15kT4HsFoTqr1K6gakAPXX5XFmBIA8Ch4P3MB3txi66AmF0DX00?=
 =?iso-8859-1?Q?m24cNK3f5YvldzlQCpgDD62wHpTNWbSU4eIbFbvOfk8Z7nwWaP9908HPky?=
 =?iso-8859-1?Q?fuELyI91r39oxQQnXegzW5LUuafGaTvnYmRyku9VFRZg4d0+mxzDSAPT+7?=
 =?iso-8859-1?Q?6FbbKS3b0PLbFQlTeSKlS+OzSWzLDOAyZ3ttRhMyL0EcDdl7pohOScpFD1?=
 =?iso-8859-1?Q?fgtt1VPFuAiVKPDstCpryd4Uaq0Hr+RmAMdmlq2bu1o82VZ4xdk+Q7x3sj?=
 =?iso-8859-1?Q?GDylmDwKr0rBUlgi128v78Vryc4xS8ZHofURVdS4JPK3bjveUPHD7Us+hu?=
 =?iso-8859-1?Q?71amXQWDdQYHPH+dRhchYGeCvbIkifpm3j4QrbqZAwX0sG/qnznjLj3T1W?=
 =?iso-8859-1?Q?jNF7cUv1kep5Ar4+h31PNosalDBVauJ5LvJOfGnCpZ9THQUnXF74Kubu7o?=
 =?iso-8859-1?Q?tSLlahMsf1scv1LM8sfcP8Q66KzxF1ApMbFCncVWtvvYr3Y1xMtWw+fiNw?=
 =?iso-8859-1?Q?mImvgoeZyQ3tjCQ4r/sJjNVaaPV5AzwYVSoYn80kQeC47hMNYKjCGBTLVk?=
 =?iso-8859-1?Q?CpJsnqz191I3JicjNlOvbRqpxskPfjw9/y1aTK/OfEXIWM6Pn497XDp3q5?=
 =?iso-8859-1?Q?kbE3xjU/u+BKmvnneysiOG5yhPQlf6X/EwdWpzMcGb5ADFDX8cG/p1RXSk?=
 =?iso-8859-1?Q?9Hr0PNzmCDM3/1ouV+E6RFzvObs5Dltd7DTZGOZ+RtN5G5mWi1Weba59Zn?=
 =?iso-8859-1?Q?qDBeM8sXpPFStgKL+cjmlHtkLMbN3hR/nq5tgsLZiTaBbBz9H//fgvrKZT?=
 =?iso-8859-1?Q?bN6NaQE4fpzI+TSizC++h9gIUKSx4fV1AFWvZu0ehjT94cTNllvluXYKPZ?=
 =?iso-8859-1?Q?A7FjVO1GKdqE1zVTn40dpcVUvmwYy2nzQnYxY0+Berf6uVr2poz56JFIgS?=
 =?iso-8859-1?Q?rlcvawK6szF/QDKOBZldHLi/ujxDjdOEnQ9oI284myaPSlO2K6BEGgoAmb?=
 =?iso-8859-1?Q?1wwP/z7WqixWGqEKpp5xw+d5zVGQJ2oozzWX+1+zSG7FFLeOPPxFldectX?=
 =?iso-8859-1?Q?FMrQ7SWCEr2OoykAJnk2iE0qAbI41wDY+VohSFDV8JUcrmaUjjE3tP4YuA?=
 =?iso-8859-1?Q?PuUYy9/umT56+iXuQSE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bded403d-4268-44dd-f2f9-08dcef6daec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 12:09:14.1870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTvWF9uEiUODXGVgoMTEvBKr0L2OfmQSu5tNsbAg1y4GhnJaLRwXGAX7o7KFexFZo0wLdQ9ojXCERnDICadCuUp6RAgyLC1uTuyyz/Pg5Sxz7zwRl/cckYUZOKUy0vEm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3578

Hi Jean,=0A=
=0A=
Thank you for your suggestions.=0A=
=0A=
>thanks for the patch, but for me there are multiple important issues there=
.=0A=
>=0A=
>You cannot prevent runtime_suspend to turn the chip off since it is its pu=
rpose. If you want to keep chip on when pedometer is enabled, you need to u=
se >pm_runtime_resume_and_get() when turning pedometer on, and pm_runtime_m=
ark_last_busy()+pm_runtime_put_autosuspend() when turning pedometer off. >T=
his way you ensure the chip stays on while pedometer is turned on.=0A=
=0A=
I agree, will change it=0A=
=0A=
>The 2nd important issue, is the ODR frequency for accel with pedometer. Pe=
dometer requires accel to run at 50Hz minimum, otherwise it will not work c=
orrectly. >I think we need to enforce this inside the driver, otherwise use=
rspace may not understand why pedometer is not working correctly. We could =
prevent >pedometer from running if sampling_frequency is below 50Hz, or for=
ce frequency to 50Hz. And when pedometer is running, preventing ODR switch =
to lower >than 50Hz.=0A=
=0A=
That makes sense. it could create problems=0A=
=0A=
>Anyway, I'm currently working on adding Wake-on-Motion (WoM) feature to th=
e driver. WoM can also be used with pedometer to reduce power consumption. =
>It would be better to postpone this pedometer work and wait for WoM integr=
ation before adding pedometer support.=0A=
=0A=
That's great to hear=0A=
Could you please let me know when the integration will be completed?=0A=
 =0A=
I am also working on the tilt functionality, which is nearly finished.=0A=
 =0A=
Should I continue with this work and submit a patch for both the pedometer =
and tilt features after the WoM integration, or would you recommend droppin=
g this plan?=0A=
 =0A=
Best Regards,=0A=
Hardev=0A=
________________________________________=0A=
From:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Sent:=A0Thursday, October 17, 2024 1:15 PM=0A=
To:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; jic23@ke=
rnel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>=0A=
Cc:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@v=
ger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionali=
ty=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
Hello,=0A=
=0A=
thanks for the patch, but for me there are multiple important issues there.=
=0A=
=0A=
You cannot prevent runtime_suspend to turn the chip off since it is its pur=
pose. If you want to keep chip on when pedometer is enabled, you need to us=
e pm_runtime_resume_and_get() when turning pedometer on, and pm_runtime_mar=
k_last_busy()+pm_runtime_put_autosuspend() when turning pedometer off. This=
 way you ensure the chip stays on while pedometer is turned on.=0A=
=0A=
The 2nd important issue, is the ODR frequency for accel with pedometer. Ped=
ometer requires accel to run at 50Hz minimum, otherwise it will not work co=
rrectly. I think we need to enforce this inside the driver, otherwise users=
pace may not understand why pedometer is not working correctly. We could pr=
event pedometer from running if sampling_frequency is below 50Hz, or force =
frequency to 50Hz. And when pedometer is running, preventing ODR switch to =
lower than 50Hz.=0A=
=0A=
Anyway, I'm currently working on adding Wake-on-Motion (WoM) feature to the=
 driver. WoM can also be used with pedometer to reduce power consumption. I=
t would be better to postpone this pedometer work and wait for WoM integrat=
ion before adding pedometer support.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
Sent: Tuesday, October 15, 2024 11:20=0A=
To: jic23@kernel.org <jic23@kernel.org>; Jean-Baptiste Maneyrol <Jean-Bapti=
ste.Maneyrol@tdk.com>; lars@metafoo.de <lars@metafoo.de>=0A=
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; linux-iio@=
vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>=0A=
Subject: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality=0A=
=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=0A=
Enables pedometer functionality in the ICM42605 IMU sensor.=0A=
=0A=
The pedometer feature allows for step counting, which is accessible through=
=0A=
a new sysfs entry. Interrupts are triggered when a step event occurs, enabl=
ing=0A=
step event detection.=0A=
=0A=
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
=0A=
---=0A=
=A0drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0 16 ++=0A=
=A0.../iio/imu/inv_icm42600/inv_icm42600_accel.c | 165 ++++++++++++++++++=
=0A=
=A0.../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0 36 +++-=0A=
=A03 files changed, 211 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/=
inv_icm42600/inv_icm42600.h=0A=
index 3a07e43e4cf1..c3471b73152e 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
@@ -122,6 +122,7 @@ struct inv_icm42600_sensor_conf {=0A=
=A0=A0=A0=A0=A0=A0=A0 int filter;=0A=
=A0};=0A=
=A0#define INV_ICM42600_SENSOR_CONF_INIT=A0=A0=A0=A0=A0=A0=A0=A0=A0 {-1, -1=
, -1, -1}=0A=
+#define INV_ICM42600_SENSOR_CONF_APEX=A0=A0=A0=A0=A0=A0=A0=A0=A0 { 2, 0, 9=
, 6}=0A=
=0A=
=A0struct inv_icm42600_conf {=0A=
=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_sensor_conf gyro;=0A=
@@ -141,6 +142,8 @@ struct inv_icm42600_suspended {=0A=
=A0 *=A0 @chip:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip identifier.=0A=
=A0 *=A0 @name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip name.=0A=
=A0 *=A0 @map:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regmap pointer.=0A=
+ *=A0 @pedometer_enable=A0 status of pedometer function=0A=
+ *=A0 @pedometer_value=A0=A0 status of steps event occurnce=0A=
=A0 *=A0 @vdd_supply:=A0=A0=A0=A0=A0=A0 VDD voltage regulator for the chip.=
=0A=
=A0 *=A0 @vddio_supply:=A0=A0=A0=A0 I/O voltage regulator for the chip.=0A=
=A0 *=A0 @orientation:=A0=A0=A0=A0=A0 sensor chip orientation relative to m=
ain hardware.=0A=
@@ -157,6 +160,8 @@ struct inv_icm42600_state {=0A=
=A0=A0=A0=A0=A0=A0=A0 enum inv_icm42600_chip chip;=0A=
=A0=A0=A0=A0=A0=A0=A0 const char *name;=0A=
=A0=A0=A0=A0=A0=A0=A0 struct regmap *map;=0A=
+=A0=A0=A0=A0=A0=A0 bool pedometer_enable;=0A=
+=A0=A0=A0=A0=A0=A0 bool pedometer_value;=0A=
=A0=A0=A0=A0=A0=A0=A0 struct regulator *vdd_supply;=0A=
=A0=A0=A0=A0=A0=A0=A0 struct regulator *vddio_supply;=0A=
=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix orientation;=0A=
@@ -301,6 +306,15 @@ struct inv_icm42600_sensor_state {=0A=
=A0#define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)=A0 \=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIELD_PREP(GENMASK(3, 0), (_f=
))=0A=
=0A=
+/* Pedometer functionality */=0A=
+#define INV_ICM42600_REG_APEX_CONFIG0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x0056=0A=
+#define INV_ICM42600_DMP_ODR_50Hz=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 BIT(1)=0A=
+#define INV_ICM42600_PED_ENABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
+#define INV_ICM42600_REG_INT_STATUS3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x0038=0A=
+#define INV_ICM42600_STEP_DET_INT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
+#define INV_ICM42600_REG_APEX_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x0031 // 2 Byte little-endian=0A=
+=0A=
+=0A=
=A0#define INV_ICM42600_REG_TMST_CONFIG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x0054=0A=
=A0#define INV_ICM42600_TMST_CONFIG_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 GENMASK(4, 0)=0A=
=A0#define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN=A0=A0=A0=A0=A0=A0 BIT(4=
)=0A=
@@ -373,6 +387,8 @@ struct inv_icm42600_sensor_state {=0A=
=A0#define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 BIT(0)=0A=
=0A=
=A0/* User bank 4 (MSB 0x40) */=0A=
+#define INV_ICM42600_REG_INT_SOURCE6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x404D=0A=
+#define INV_ICM42600_STEP_DET_INT1_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(5)=0A=
=A0#define INV_ICM42600_REG_INT_SOURCE8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x404F=0A=
=A0#define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 BIT(5)=0A=
=A0#define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_accel.c=0A=
index 56ac19814250..90fe4c9e15ab 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
@@ -160,6 +160,13 @@ static const struct iio_chan_spec_ext_info inv_icm4260=
0_accel_ext_infos[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0 {},=0A=
=A0};=0A=
=0A=
+static const struct iio_event_spec icm42600_step_event =3D {=0A=
+=A0=A0=A0=A0=A0=A0 .type =3D IIO_EV_TYPE_CHANGE,=0A=
+=A0=A0=A0=A0=A0=A0 .dir =3D IIO_EV_DIR_NONE,=0A=
+=A0=A0=A0=A0=A0=A0 .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(IIO_EV_INFO_VALUE),=0A=
+};=0A=
+=0A=
=A0static const struct iio_chan_spec inv_icm42600_accel_channels[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL=
_SCAN_X,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 inv_icm42600_accel_ext_infos),=0A=
@@ -169,6 +176,14 @@ static const struct iio_chan_spec inv_icm42600_accel_c=
hannels[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 inv_icm42600_accel_ext_infos),=0A=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),=
=0A=
=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMES=
TAMP),=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_STEPS,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO=
_CHAN_INFO_PROCESSED),=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .event_spec =3D &icm42600_step_=
event,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .num_event_specs =3D 1,=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
+=0A=
=A0};=0A=
=0A=
=A0/*=0A=
@@ -668,6 +683,31 @@ static int inv_icm42600_accel_write_offset(struct inv_=
icm42600_state *st,=0A=
=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=A0}=0A=
=0A=
+static int inv_icm42600_steps_read_raw(struct iio_dev *indio_dev,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 int *val, int *val2, long mask)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdat=
a(indio_dev);=0A=
+=A0=A0=A0=A0=A0=A0 __le16 steps;=0A=
+=A0=A0=A0=A0=A0=A0 int ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (mask =3D=3D IIO_CHAN_INFO_PROCESSED) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct=
_mode(indio_dev);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->ma=
p, INV_ICM42600_REG_APEX_DATA, &steps, sizeof(steps));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(=
indio_dev);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D steps;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+}=0A=
+=0A=
=A0static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2, long mask)=0A=
@@ -681,6 +721,8 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *=
indio_dev,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_temp_read=
_raw(indio_dev, chan, val, val2, mask);=0A=
+=A0=A0=A0=A0=A0=A0 case IIO_STEPS:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_steps_read_=
raw(indio_dev, chan, val, val2, mask);=0A=
=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=A0=A0=A0=A0=A0=A0=A0 }=0A=
@@ -824,6 +866,126 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio=
_dev *indio_dev,=0A=
=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=A0}=0A=
=0A=
+/*****************Pedometer Functionality**************/=0A=
+static int inv_icm42600_step_en(struct inv_icm42600_state *st, int state)=
=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_S=
ENSOR_CONF_APEX;=0A=
+=A0=A0=A0=A0=A0=A0 int ret, value;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (state) {=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_=
conf(st, &conf, NULL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_APEX_CONFIG0,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_DMP_ODR_50Hz);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_SIGNAL_PATH_RESET,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SIGNAL_PATH_RESET_D=
MP_MEM_RESET);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(1);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_SIGNAL_PATH_RESET,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SIGNAL_PATH_RESET_D=
MP_INIT_EN);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_INT_SOURCE6,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_STEP_DET_INT1_EN);=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 value =3D INV_ICM42600_DMP_ODR_=
50Hz | INV_ICM42600_PED_ENABLE;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_APEX_CONFIG0, value);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->pedometer_enable =3D true;=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 } else {=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_APEX_CONFIG0, 0);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, I=
NV_ICM42600_REG_INT_SOURCE6, 0);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->pedometer_enable =3D false;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 return 0;=0A=
+}=0A=
+=0A=
+static int inv_icm42600_write_event_config(struct iio_dev *indio_dev,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct iio_chan_spec *chan,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_type type,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_direction dir, int stat=
e)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdat=
a(indio_dev);=0A=
+=A0=A0=A0=A0=A0=A0 int ret;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if(chan->type !=3D IIO_STEPS)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_step_en(st, state);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
+=A0=A0=A0=A0=A0=A0 return ret;=0A=
+}=0A=
+=0A=
+static int inv_icm42600_read_event_config(struct iio_dev *indio_dev,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct iio_chan_spec *chan,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_type type,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_direction dir)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdat=
a(indio_dev);=0A=
+=A0=A0=A0=A0=A0=A0 int value;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (chan->type !=3D IIO_STEPS)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 regmap_read(st->map, INV_ICM42600_REG_APEX_CONFIG0, &va=
lue);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (value & INV_ICM42600_PED_ENABLE)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1;=0A=
+=A0=A0=A0=A0=A0=A0 else=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
+}=0A=
+=0A=
+static int inv_icm42600_read_event_value(struct iio_dev *indio_dev,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct iio_chan_spec *chan,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_type type,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_direction dir,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum iio_event_info info,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
+{=0A=
+=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdat=
a(indio_dev);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (type =3D=3D IIO_EV_TYPE_CHANGE) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->pedometer_value =3D=3D =
true) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =
=3D 1;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->ped=
ometer_value =3D false;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =
=3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
+=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+}=0A=
+=0A=
=A0static const struct iio_info inv_icm42600_accel_info =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D inv_icm42600_accel_read_raw,=0A=
=A0=A0=A0=A0=A0=A0=A0 .read_avail =3D inv_icm42600_accel_read_avail,=0A=
@@ -833,6 +995,9 @@ static const struct iio_info inv_icm42600_accel_info =
=3D {=0A=
=A0=A0=A0=A0=A0=A0=A0 .update_scan_mode =3D inv_icm42600_accel_update_scan_=
mode,=0A=
=A0=A0=A0=A0=A0=A0=A0 .hwfifo_set_watermark =3D inv_icm42600_accel_hwfifo_s=
et_watermark,=0A=
=A0=A0=A0=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_accel_hwfifo=
_flush,=0A=
+=A0=A0=A0=A0=A0=A0 .write_event_config =3D inv_icm42600_write_event_config=
,=0A=
+=A0=A0=A0=A0=A0=A0 .read_event_config=A0 =3D inv_icm42600_read_event_confi=
g,=0A=
+=A0=A0=A0=A0=A0=A0 .read_event_value=A0=A0 =3D inv_icm42600_read_event_val=
ue,=0A=
=A0};=0A=
=0A=
=A0struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index c3924cc6190e..4d78cb5ca396 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -15,7 +15,8 @@=0A=
=A0#include <linux/pm_runtime.h>=0A=
=A0#include <linux/property.h>=0A=
=A0#include <linux/regmap.h>=0A=
-=0A=
+#include <linux/iio/events.h>=0A=
+#include <linux/of_irq.h>=0A=
=A0#include <linux/iio/iio.h>=0A=
=0A=
=A0#include "inv_icm42600.h"=0A=
@@ -533,6 +534,19 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, v=
oid *_data)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG_INT_STATU=
S3, &status);=0A=
+=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (status & INV_ICM42600_STEP_DET_INT) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_event(st->indio_accel,=
 IIO_MOD_EVENT_CODE(IIO_STEPS, 0,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_NO_MOD,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_EV_TYPE_CHANGE,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_EV_DIR_NONE),=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->timestamp.accel);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->pedometer_value =3D true;=
=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG_INT_STA=
TUS, &status);=0A=
=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
@@ -860,12 +876,20 @@ static int inv_icm42600_runtime_suspend(struct device=
 *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 /* disable all sensors */=0A=
-=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SEN=
SOR_MODE_OFF,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_OFF,=
 false,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
-=A0=A0=A0=A0=A0=A0 if (ret)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_unlock;=0A=
+=A0=A0=A0=A0=A0=A0 if (st->pedometer_enable) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mg=
mt0(st, INV_ICM42600_SENSOR_MODE_OFF,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_I=
CM42600_SENSOR_MODE_LOW_POWER,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 false, N=
ULL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto er=
ror_unlock;=0A=
+=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mg=
mt0(st, INV_ICM42600_SENSOR_MODE_OFF,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_I=
CM42600_SENSOR_MODE_OFF,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 false=
, NULL);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto er=
ror_unlock;=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0 regulator_disable(st->vddio_supply);=0A=
=0A=
=A0error_unlock:=0A=
--=0A=
2.43.0=0A=

