Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53E25F2CC5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Oct 2022 11:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJCJFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Oct 2022 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJCJEv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2022 05:04:51 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FE10EA
        for <linux-iio@vger.kernel.org>; Mon,  3 Oct 2022 01:58:11 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 292MB0TC022281;
        Mon, 3 Oct 2022 08:27:26 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2177.outbound.protection.outlook.com [104.47.7.177])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3jxbwyrxcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 08:27:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNZLacu0eFHgoOKpZa0u4MKCa7p5wmqlmQ9hXJp12eFOxaxgA1LVMOGlMJ/Jgr2JFR81BYS84WZqHQ7pyOfUBops413qOnp7q5z8k2dla1Dkj94/EeQX3e2BMj/IUoGeJT5kNZP0DMluiGSa3jRbwX4lsT6L7zcb68F6nA0VuyLZO4w1bvlmkecGm4BAmR2RGjiFVW/iLEtGSEjwmm5H01aXg1JLL+Qb/hCEhuEti0pfCGGqj04WYDEcJac7Pf4tsYUPzZQQhn/cztVL5ZoFPVqCHPZLWCUO2snPc203KSXgVdKdFsCr3h9cIRuboUZlKr6uybPx60A32O+RCfPbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q4I2IetxuiY5xE08SMNdX7UMUZQFaBtdYp6Xft6CiY=;
 b=B/wWOApeb8wfEpZXqdbe9lb+TfX2H2/7hefkqdxMlL2HJdU4hS7rw45XKDvDhyEbEPU3m3PajoW5FCe/nZHYY7ujeuQAdn+Lfe5+fOY1e2x3NDjfMsBR8OF8cbMSoQ8xmJr6hUwMJh3Wjw77gfKCSKioRhm9NUQ0pnZIdXN75bUAumksDi7Rxq6EAXFLZSLAhQ2UvTaKwBm8a+Ll5UpsnevDkIbpHG6Iay5CEl+bWCQOfQwi5+ZOzUdo7y8hvcUg4IzWnKFOe41mn/+tLazbwr3GVCRdUznx6wEt7npcMd+5jjGD765yo+He9qJeMv/7HSD71+vwireqCaFnwPi9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q4I2IetxuiY5xE08SMNdX7UMUZQFaBtdYp6Xft6CiY=;
 b=FWQMN4PmgyaJ3Z2b6MCpQCpkji+jwoD8XkoBuHl7Fn/iOgy1iibChAreh/9aLmU4cyP0RI2yvElllFkDYq3xR2bBN+74IH3SEqhY1qevb1nBVwAri3rhBvl0jtx0socsAoaWNG2+p0s2JA0gNzjK+cuXK+BVtYpy678gx7FAjHBOPXgwbqB1W6qC/jG8Ux4Ctq/tdGx6GAO9I2JA7q85XBOkhxzNZTBfqS1z8EyyIpeATpmSgnqethh072CpVAyZQVH0lD2UWu+ZSpoIUgHjpXyi+eryGD00mpjujI8ZgePPf1ptxG2LI6ij+r2KLbxpXeWfr7cLnyKHjE0yDk+qDw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB1723.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:83::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 08:27:22 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6bd3:d0ae:114a:b17a]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6bd3:d0ae:114a:b17a%9]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 08:27:22 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/5] iio: imu: inv_icm42600: Move exports to
 IIO_ICM42600 namespace
Thread-Topic: [PATCH v2 4/5] iio: imu: inv_icm42600: Move exports to
 IIO_ICM42600 namespace
Thread-Index: AQHY0PeKrWdMaindm0Ktsa/goij1ea38YcaC
Date:   Mon, 3 Oct 2022 08:27:22 +0000
Message-ID: <FR3P281MB1757858C225DBE0AF599DFB1CE5B9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20220925155719.3316280-1-jic23@kernel.org>
 <20220925155719.3316280-5-jic23@kernel.org>
In-Reply-To: <20220925155719.3316280-5-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB1723:EE_
x-ms-office365-filtering-correlation-id: 1b041c36-84d4-4881-ac15-08daa51917fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGVYdJ8Eal1E2f6J1RivPSCwWF2CMD2NQ7Xz/0/BaW0DdjskcYNW/JCSdrrvAoxeYUZSwQc1f9CFtWR3Wj2mPqOqFlknESwXtCE2bTDsPLn3U/Zv7cx28pLWPhz6SS1uzXVH4TzMuKD0oNYWcJ4Ga18DoA5h4qX8EXUd+rIQPvQHwdKLCHmegAQU8ipM12805oC6uyHljqRYefkjTrd969cUCltfwAv2x9J9BfsW+OwSui/R+c7d7iyUJwGXpedpiVL3aS9edJ2flHlNoNEfihGJKpzysTmvC04w2STx0oVs+mOJKGfX/Rjk7JwEexfk9byU5zLv8MyfdYkMaYEOw2tp2iEDz/4O33191CC3lH6UpurJepZD/pt3VrGey6QyQKCuBcmljkZq3PtTH32tQM+Fkw/FCG0YwNzhdEbTCb8nNf7ymkk/4IEdo9lt5CKAUIkTGoZTkGGw/R5BtYZ22I74r4DQBGUMMInR0p6v3TEbYcA3UxuwXOojD95YQ0Xik0WpTO4rhfcE29YIji7u2x6Z+r+odNkGMR9X9j1vO7datRZrUIgXU8LSu51DqCXcILnpwEe+N1p7XnV7TAZOauOTafgG/fuL+a8MtT1f/lRq0UUe2mIFzLZFogEwiCrjTYviu19v53/YVoNtiXy+p7DchuUJkFGOgQRrUEmMWxlI2zqY4trmJMsHubwR6/DWJo6NBDSVkmLzxlDr3wwjBro57wNKnO03LxxNDdITZdZVRrmllUa7PifN3/x7Cwd8GIi1QshSlOFdSdTyhcGr/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39850400004)(451199015)(110136005)(54906003)(86362001)(478600001)(71200400001)(52536014)(41300700001)(8936002)(5660300002)(91956017)(316002)(76116006)(33656002)(4326008)(66446008)(64756008)(8676002)(66946007)(55016003)(66556008)(66476007)(83380400001)(38100700002)(186003)(6506007)(26005)(9686003)(7696005)(53546011)(122000001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?joLQToaX9qSMP3FSEaVwb299+YgUq4qWsletpJ/bST1ojYiVa8qmTwOxE8?=
 =?iso-8859-1?Q?PNcqF0Y5R8+psM685zJZhe1MRzSuypKRt7ZvaJ4QOJjEsK1R7AvS6OhRaA?=
 =?iso-8859-1?Q?rJS7YVqSH0FMvdtGwqure0PgcarY6y5kCq8XZvFKJyCfBche8BxfhmWrmF?=
 =?iso-8859-1?Q?qoPtlqi3K3V1gvWGcZ0yePuglRODlal77zzGFVDXGZyRmJFt5ExGjPQE08?=
 =?iso-8859-1?Q?zaju8UetIBhzpPbfpI26E0S/kbu53oQOvahqMgX9W4HyZYfmF8NrcIBren?=
 =?iso-8859-1?Q?FAcv395EAHNhtiZmfSvz1p5jbAe39b17ckQ5kqGg3e6N855FgZ3E9ZriGS?=
 =?iso-8859-1?Q?DU+RHaDGfezabqNj0PMVcbUm+8/FjObTLjEy3gxPAjUGmhDtyaxjz39+Om?=
 =?iso-8859-1?Q?1nZLkcaTqFhURjzy+FInVCA6rl5tJZERsksyIvMLAHiYJbTQcufYT5TlcT?=
 =?iso-8859-1?Q?utl95F3v0FJHLzDKnh6EsBN1aEIya4dY67kJRbAog+6OQm8tge8wUpQb7M?=
 =?iso-8859-1?Q?Gi6taVyBu8hd6OeAyafDI6+A5PYe1hNsygLoJBj3G4bY15LmDV4LrKdB55?=
 =?iso-8859-1?Q?zH1GJ890/d71LV9lttb7CijfX+OSW1gp+z1Bex3m8fqjDBCZ8pfHq5Phn7?=
 =?iso-8859-1?Q?a279CJieutA64iEdYYeWtnFvjHlnlqkUKtTB3i8pYm1HZtNX8nwN0fLcqc?=
 =?iso-8859-1?Q?WjdsK9mXniIgOzWI+/TfCKkdlgQTu2DuwbliwCe0N1w4C2p/ahyeMvbGLm?=
 =?iso-8859-1?Q?6gPfLaWV68PE20hAacoAkFsrUyJYBiOkfE+XH8RruEUooIi6Qww2PEq0CU?=
 =?iso-8859-1?Q?CSYqRZ/pWC4zakI0k1M6k77sFKgvZvT0S3T+Un1quBkxPwLzIXNVpkQWXA?=
 =?iso-8859-1?Q?JSEKoIcqENcg9CEkdx7duFJa2P1Q7zoq9R5qZOaIr5szybjWRBLkPOQZo2?=
 =?iso-8859-1?Q?E02zLkAQ0p/nnk8PAZGTHQ2FVIBubi/dddlvKPnk57PaPH/5sxt9GBfH75?=
 =?iso-8859-1?Q?1LMCdkcMH3Yb8V0Lnjatweu/QshzeDLcqAkWWrJ8RpNJBIzgWEb22Sqoef?=
 =?iso-8859-1?Q?Vz8KhOz5KdkQedxz7FkO1fxaghAcN45ZfLszOdkpiMcErFxe3h0lpSFQvk?=
 =?iso-8859-1?Q?ls9tSRpdzZNuhVk46L/Qc8pv8+ml1u4rCgsNNFDBUHKCOCn4cn+41M944d?=
 =?iso-8859-1?Q?4gllZ8rZjkmJBt/UpN3L/mdvxjoeMKSn8ZcURD4ZMfnWaWr2t3fuvwaAPV?=
 =?iso-8859-1?Q?BQfr4VNbqk6CrvVH9aBOdEpU+T/tj7e7jV2BlQ8x4EawZ5Eg6wKNUbIxBo?=
 =?iso-8859-1?Q?dqAKC6Ljl32tNbQlhzYXCXqFhsj4fdEetzECDv7qNxqgNd/RQIDfQoXWA4?=
 =?iso-8859-1?Q?/gaU2k6pKU0hlqu+QtRtS5w3oPXwaXreyfw4T3MMtzkNQ1ueewAK5ynu7m?=
 =?iso-8859-1?Q?91m8pwgPJUha1S4Uf1TNPVlTtw/mnLdJr/dP1n9LwqJnrWkX5/WTiC3cmf?=
 =?iso-8859-1?Q?ByhOYva/g1jgadN5+5YsArehFT9/PCYVTMQo220f2nmOs3rpwBUt2koUXE?=
 =?iso-8859-1?Q?mZlKPlT4CcbrYM8iQnDEtF58IYrEKJYtmQzFIwx9cJkd7R66nej8fmOGqd?=
 =?iso-8859-1?Q?naIGmwX2F0A+yV0OPRn7yNqJprV5SNG1Rj/9msK4w4jzyUPq6q5edriw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b041c36-84d4-4881-ac15-08daa51917fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 08:27:22.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XphIATfmRTDjYhZkiWbN/xdCkdec98YYkKxm9XZotUZpbhDjC35nt7MXiZPXD8+P/pU/L/gfFceYe/Jy3q8703i4aPMzAgktgcKZCnu5sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
looks good for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, September 25, 2022 17:57=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Rafael J . Wysocki <rafael@kernel.org>; Paul Cercueil <paul@crapouillou=
.net>; Linus Walleij <linus.walleij@linaro.org>; Sean Nyekjaer <sean@geanix=
.com>; Rui Miguel Silva <rui.silva@linaro.org>; Jean-Baptiste Maneyrol <Jea=
n-Baptiste.Maneyrol@tdk.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com=
>=0A=
Subject: [PATCH v2 4/5] iio: imu: inv_icm42600: Move exports to IIO_ICM4260=
0 namespace =0A=
=A0=0A=
[CAUTION] This is EXTERNAL email. Do not click any links or open attachment=
s unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
As these exports are only relevant to core module and users in the=0A=
bus specific modules, move them out of the main kernel namespace.=0A=
=0A=
Includes using EXPORT_NS_GPL_DEV_PM_OPS() and the simplifications that=0A=
brings by allowing the compiler to remove unused struct dev_pm_ops=0A=
and callbacks without needing explicit __maybe_unused markings.=0A=
=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
--=0A=
v2: Switch to Paul's more flexible version of the=0A=
EXPORT_NS_GPL_DEV_PM_OPS()=0A=
---=0A=
=A0.../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 | 21 +++++++++----------=
=0A=
=A0.../iio/imu/inv_icm42600/inv_icm42600_i2c.c=A0=A0 |=A0 3 ++-=0A=
=A0.../iio/imu/inv_icm42600/inv_icm42600_spi.c=A0=A0 |=A0 3 ++-=0A=
=A03 files changed, 14 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index ca85fccc9839..b63c5dab1a56 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -41,7 +41,7 @@ const struct regmap_config inv_icm42600_regmap_config =3D=
 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .ranges =3D inv_icm42600_regmap_ranges,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .num_ranges =3D ARRAY_SIZE(inv_icm42600_regmap_ran=
ges),=0A=
=A0};=0A=
-EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);=0A=
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);=0A=
=A0=0A=
=A0struct inv_icm42600_hw {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 uint8_t whoami;=0A=
@@ -660,13 +660,13 @@ int inv_icm42600_core_probe(struct regmap *regmap, in=
t chip, int irq,=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return devm_add_action_or_reset(dev, inv_icm42600_=
disable_pm, dev);=0A=
=A0}=0A=
-EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);=0A=
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, IIO_ICM42600);=0A=
=A0=0A=
=A0/*=0A=
=A0 * Suspend saves sensors state and turns everything off.=0A=
=A0 * Check first if runtime suspend has not already done the job.=0A=
=A0 */=0A=
-static int __maybe_unused inv_icm42600_suspend(struct device *dev)=0A=
+static int inv_icm42600_suspend(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(=
dev);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
@@ -706,7 +706,7 @@ static int __maybe_unused inv_icm42600_suspend(struct d=
evice *dev)=0A=
=A0 * System resume gets the system back on and restores the sensors state.=
=0A=
=A0 * Manually put runtime power management in system active state.=0A=
=A0 */=0A=
-static int __maybe_unused inv_icm42600_resume(struct device *dev)=0A=
+static int inv_icm42600_resume(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(=
dev);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
@@ -739,7 +739,7 @@ static int __maybe_unused inv_icm42600_resume(struct de=
vice *dev)=0A=
=A0}=0A=
=A0=0A=
=A0/* Runtime suspend will turn off sensors that are enabled by iio devices=
. */=0A=
-static int __maybe_unused inv_icm42600_runtime_suspend(struct device *dev)=
=0A=
+static int inv_icm42600_runtime_suspend(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(=
dev);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
@@ -761,7 +761,7 @@ static int __maybe_unused inv_icm42600_runtime_suspend(=
struct device *dev)=0A=
=A0}=0A=
=A0=0A=
=A0/* Sensors are enabled by iio devices, no need to turn them back on here=
. */=0A=
-static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev)=
=0A=
+static int inv_icm42600_runtime_resume(struct device *dev)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(=
dev);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
@@ -774,12 +774,11 @@ static int __maybe_unused inv_icm42600_runtime_resume=
(struct device *dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=A0}=0A=
=A0=0A=
-const struct dev_pm_ops inv_icm42600_pm_ops =3D {=0A=
-=A0=A0=A0=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42=
600_resume)=0A=
-=A0=A0=A0=A0=A0=A0 SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 inv_icm42600_runtime_resume, NULL)=0A=
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_ICM42600) =3D {=0A=
+=A0=A0=A0=A0=A0=A0 SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_=
resume)=0A=
+=A0=A0=A0=A0=A0=A0 RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm426=
00_runtime_resume, NULL)=0A=
=A0};=0A=
-EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);=0A=
=A0=0A=
=A0MODULE_AUTHOR("InvenSense, Inc.");=0A=
=A0MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_i2c.c=0A=
index d4a692b838d0..4f96989ddf4a 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
@@ -93,7 +93,7 @@ static struct i2c_driver inv_icm42600_driver =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .driver =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "inv-icm42600-i2=
c",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D inv_ic=
m42600_of_matches,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm =3D &inv_icm42600_pm_ops,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm =3D pm_ptr(&inv_icm42600_pm=
_ops),=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .probe_new =3D inv_icm42600_probe,=0A=
=A0};=0A=
@@ -102,3 +102,4 @@ module_i2c_driver(inv_icm42600_driver);=0A=
=A0MODULE_AUTHOR("InvenSense, Inc.");=0A=
=A0MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");=0A=
=A0MODULE_LICENSE("GPL");=0A=
+MODULE_IMPORT_NS(IIO_ICM42600);=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/=
imu/inv_icm42600/inv_icm42600_spi.c=0A=
index e6305e5fa975..486b46e53113 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
@@ -89,7 +89,7 @@ static struct spi_driver inv_icm42600_driver =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .driver =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "inv-icm42600-sp=
i",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D inv_ic=
m42600_of_matches,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm =3D &inv_icm42600_pm_ops,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .pm =3D pm_ptr(&inv_icm42600_pm=
_ops),=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .probe =3D inv_icm42600_probe,=0A=
=A0};=0A=
@@ -98,3 +98,4 @@ module_spi_driver(inv_icm42600_driver);=0A=
=A0MODULE_AUTHOR("InvenSense, Inc.");=0A=
=A0MODULE_DESCRIPTION("InvenSense ICM-426xx SPI driver");=0A=
=A0MODULE_LICENSE("GPL");=0A=
+MODULE_IMPORT_NS(IIO_ICM42600);=0A=
-- =0A=
2.37.2=0A=
