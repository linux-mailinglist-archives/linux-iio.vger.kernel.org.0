Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA157C6A0A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Oct 2023 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjJLJxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Oct 2023 05:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJLJxv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2023 05:53:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FAB8
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 02:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKT5Lqy+Qk5cgaA4qik1/aFU8Kkbu5VLjZKjaH9R3v+nLu7gWpj1V4hxhd1E3nYZSL+vwr1Ngam7SrohUMx72dc/ufNC+o8oIiSMJWCEUWuIb2iicJCq+vBhktvdt5/axfByIgK+UXx/aLd5EGhhDqb322v6MGzP5okggBNgTTQxd/G6PRlF3NqGr0LGtJZrwVGgognXFg+89ayqNifC+w5KFvRqnlx2FEL8wXNxgeC+YAyIt+n9sv2AeCEh/17MP70LHxXiCJwmCpGxOJc0RhRJPqJtmevcqYxVi53+SwgZDYIfMZzoDL3neJ1QNXVnHbPSY9EkbPDAselMZifBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YKwESUU1xrPeLQI6G6xb+gr4SHUtcFaga8jchV0wLw=;
 b=MUxp3G1rSHMbkJyiH8F+Y6qrdC8qIK7EmvwLAT9PvZYl1U6w1YvyHEHRgszyp6cF4w9FlEgMM3XrODtzpKKYLfCBhy8x3ZAf17dgTVulkujOxSH4nD1LJ6nferGBvqyVYoeHkfPIoCQZCGl9JLsiOYPjiYt8uTyanEDaVa4dSruGH4NmZe4gnLi6wCRAaUbPlPmZtRNSLUeOK0ZvfURm7/4A8p3zRaTc/xtDErJmc//TbhURmq4zDMfA/qS/BuZrqUuDCadXh7cAvP/oEX63uvHqJXpTEgeHFDGT4pcn93acIwNbFiwPkttrOsExGVoXWoPA9Izd2vHQ/imTzbys+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YKwESUU1xrPeLQI6G6xb+gr4SHUtcFaga8jchV0wLw=;
 b=HZ0Co4UGjV02wH8ISPadg/OLzzMl2yR/2ww3cSsOOWfrjdukAOC3WWZksRAIJYzV36BYKExszBilbJfQIxRS0r1GyWCbVUjbGwuoNWD5MCAe1hFeLdudDugF03CeCvyTXbOtfZkLsaY20mLahnCv53AL4FgJXr7pOpj9pH5S8N4=
Received: from DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:53:44 +0000
Received: from DM6PR12MB4217.namprd12.prod.outlook.com
 ([fe80::3433:e991:bbfb:4241]) by DM6PR12MB4217.namprd12.prod.outlook.com
 ([fe80::3433:e991:bbfb:4241%7]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 09:53:44 +0000
From:   "O'Griofa, Conall" <conall.ogriofa@amd.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>
CC:     Robert Hancock <robert.hancock@calian.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 0/2] Xilinx XADC fixes
Thread-Topic: [PATCH v2 0/2] Xilinx XADC fixes
Thread-Index: AQHZ56FZzqKXuJq4e0evGePhdvWBjbAqOhEAgBkhwQCAAq/jEA==
Date:   Thu, 12 Oct 2023 09:53:44 +0000
Message-ID: <DM6PR12MB4217D5104DF438AA05039CC58BD3A@DM6PR12MB4217.namprd12.prod.outlook.com>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
        <bae646e9-7977-4de3-927b-ffcb7a94ac48@amd.com>
        <20230924173210.13f2bf85@jic23-huawei> <20231010171928.75451192@jic23-huawei>
In-Reply-To: <20231010171928.75451192@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=487dd0ef-8a8e-4cd8-acd0-49a43d83c0aa;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T09:21:30Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4217:EE_|DM6PR12MB4401:EE_
x-ms-office365-filtering-correlation-id: b99bc945-bbf4-4925-0a1b-08dbcb091f7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59R+7HZthj85rsyN3I18FK0RDc5QW8yIcFJYoNEQGpQSsyoS5DNM7y2SdakYjOaXx6YbI5EBlvUvSojw0di3UQCppVvFxU7h/uXixlqQ8n+XySnOf1Fa+1G+aHKTe7y6wC1UQtY7Emm0pBAmqwcBl5v9C7Cvy6aKvEhf/SJMsDXCAxpRtw2Yg/uPeQL3zHxKZ3DMBkhoas48SdlTHkD9QjasoW3HNxWHK6rckwMhHGPXCPX/2uKrgwEpOK6UwgovGIiszhJiqIGsjZ4Eq8xDKWzUgoFBuwj+Y0ziM5EsIdJw3WRe6FsQ8B5Y1kYviAVVQLkh6tQzZuLN2wYmLSV+YriFIoEkMUKWnsjoMdovjg+DKeeHrBMHWXpSXvFglj/6SQdrSBwM5GAaQKdgv6WeORFpyU2xF0Yz2ekuenBF+/dZgsyHNMAzn+T3e7ZgwamRXBgshjiFrUHG8rr0+52nM/1BB153xjcznuqcOG3B05zB2pdtZ6gWRQly4iApHR26KC+blYvJYE/fI3FnS1ncwHiSopGbTfI0IXdXHkDUX5GzeSOU/LVkIdVZU2v72xb7a9dDhhVpEYLF9EXp9EeagYKKufLl8zwjh1eb/vYBrJJ4QT6F5nsU3+j1eoUsJViF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4217.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(33656002)(2906002)(8676002)(8936002)(4326008)(55016003)(83380400001)(26005)(5660300002)(86362001)(52536014)(9686003)(6506007)(53546011)(7696005)(478600001)(71200400001)(122000001)(41300700001)(6636002)(38100700002)(38070700005)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0YmBKI5jqTbM8Tprres6S+wndg6LPZhDLaU/dCL2aR8nlvg9UtJDn/p/Hdl?=
 =?us-ascii?Q?X4isn+OwosnJ3Ql6d4zShg/3PWb7tnLcf+w4g4r/ABhg2E9iec7iSlli0Uk6?=
 =?us-ascii?Q?5z6bK5EN7VgcVsbkQuquxmeCaKAzT3kRJBrSD2q5Vf2Rl3Sm73QzPyeMle+B?=
 =?us-ascii?Q?EKaN/mdHsamhjahebJBNDfVheZN9chdIGMQwmRAbqrV4omjM7gj1KQzx0km9?=
 =?us-ascii?Q?Rm56Hzb9h6TqVGLykzDOfX5XzxsVkT6cNPxQ+BPy/nHuLZufr+u2X2x3bQHV?=
 =?us-ascii?Q?ZXy/F4I5Vtdq99CcwLk1q6nQwlB/8DXaB6TfxnxQcuUuohAjJtoUvvbIYtZ0?=
 =?us-ascii?Q?Lh6bwtFOGJq3lYCCPNP6v94VR5uJgl3K1i7R7StLckJwp2ZohWrYSN+ytIP7?=
 =?us-ascii?Q?7fbmAgF7fB+92uLmgKRClmxSt9dmQ5V1Oo/KbPg1/2+QB89ruOoK/D0WnOwP?=
 =?us-ascii?Q?nOnP6GfcC9FS71HgoNTxM69jHcCURv3iEPHoZXXvOvXPj8OEHQn54K7V2t7o?=
 =?us-ascii?Q?+AAGwbbLwsyg6xnZHXOexlDdtrwvfktfgD44hc50Km4AIix4Fhe191hZIIP3?=
 =?us-ascii?Q?u6gbDNC13/ZtufDQmtJAYmU7fl77BNal7+87iT0Ouz2BIq62MSZBDsU07snl?=
 =?us-ascii?Q?79iQu1ZVrMu4xW95N9k7wAt9i+8m+RSGlm3AQdJScZiRreUeBv6XfqbP/flO?=
 =?us-ascii?Q?XGpjW6G3k56R6HhGmNYMjlVqYL16zzX2PCH/H17Z6kcX4Of/GhxbOkJXP6Aa?=
 =?us-ascii?Q?9rHxeYvZROdfWHIG148Ldcmfada38V80aXGxoEyO1xLCzrNlmGsm5Bks5y4e?=
 =?us-ascii?Q?hnbLuzv/Osc+isc6rIksWkdNljAynNVqurGmnFYpqDBCM+n9DVqulcPN6ff1?=
 =?us-ascii?Q?pXNSGe36muQbGxYkCheylEUIZKAYQZ9IvE8g8dLXofa0jVwonvB3HQ4MdqXX?=
 =?us-ascii?Q?OKH8i4EJfVmPyME30sr8Oq6luJmnDMuZjwzFpXk7csp3nq+Ceayv9PV2aoFW?=
 =?us-ascii?Q?RQ/hAKMvh9IguEUwpprxNPBMkWwREifhm02gYSn7O/FuBydhfPD1Ay3Yt0Mm?=
 =?us-ascii?Q?C/MbWS+G9N7CAe3k+G4cJ1op3/pVyA9jhyoRE9zek0Bpbi6jZQc0f7BF39jO?=
 =?us-ascii?Q?91M5K11ijEuwShFjkSWgV0yTQSL3GQx49w+EiPOEsbReSvSF2JwyePQCT87p?=
 =?us-ascii?Q?htE8MaKA595i5yeudC+zvpV81fC6ORBwSQi+9gPRcAZa13ffiI071vrJ/gJ5?=
 =?us-ascii?Q?+czSVrIZrSjB1+qi4IEVlnpqHiBybR9APhO+Kvf8q5PwyzpFYRA5fMcR+2Sx?=
 =?us-ascii?Q?L50RT+02aUIPH0sOumgwTJvsMZet5b01/7MjqZ6B6NyRouLnBFYTaO8fEo29?=
 =?us-ascii?Q?mLaJsckYloTyt8NRSwBswaQfhxRmuwcVB+Z+jrvBbngg/HtDHBbaROrTgmwh?=
 =?us-ascii?Q?fPHWInQehIU7VRL3tuPTu0yG5nO+iXu78jItKOO79CU5F50CB5VFY9cHvcSk?=
 =?us-ascii?Q?AKMsnZzW0AhN+/9L708+42PV5+3t3Sp+UxjRYZJcEm6sHmCZWbRWp8+uOIx/?=
 =?us-ascii?Q?5vhrNaewWAC3gwfIMSw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4217.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99bc945-bbf4-4925-0a1b-08dbcb091f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 09:53:44.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiEGeQpCuN9cNfdQop/81o0HIlOs7t5behJGDtP2FkYduPyQQDN7/pgEy+muwZ+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[AMD Official Use Only - General]

Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Tested-by: O'Griofa, Conall <conall.ogriofa@amd.com>

Hi Jonathan,

Thanks for the patches, changes look good, I have tested on board and not s=
een any issues from my testing.

Cheers,
Conall.
> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, October 10, 2023 5:19 PM
> To: Simek, Michal <michal.simek@amd.com>
> Cc: Robert Hancock <robert.hancock@calian.com>; O'Griofa, Conall
> <conall.ogriofa@amd.com>; Lars-Peter Clausen <lars@metafoo.de>; linux-
> iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 0/2] Xilinx XADC fixes
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Sun, 24 Sep 2023 17:32:10 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Fri, 15 Sep 2023 08:52:49 +0200
> > Michal Simek <michal.simek@amd.com> wrote:
> >
> > > +Conall
> > >
> > > On 9/15/23 02:10, Robert Hancock wrote:
> > > > Fixes for a couple of issues in the Xilinx XADC driver: one where
> > > > preconfigured temperature/voltage thresholds were being clobbered
> > > > and potentially breaking overtemperature shutdown, and another for
> > > > inaccurate temperature readings on UltraScale family devices.
> > > >
> > > > Changed since v2: Updated to also remove disabling XADC alarm bits.
> > > >
> > > > Robert Hancock (2):
> > > >    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
> > > >      thresholds
> > > >    iio: adc: xilinx-xadc: Correct temperature offset/scale for
> > > > UltraScale
> > > >
> > > >   drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++--------------=
-----
> > > >   drivers/iio/adc/xilinx-xadc.h      |  2 ++
> > > >   2 files changed, 16 insertions(+), 25 deletions(-)
> > > >
> > >
> > > Conall: Please test and review.
> >
> > I'm sitting on this one until I hear back.   No huge rush, but if you
> > can estimate when you'll get to this I know to leave you alone until
> > after that!
>
> I'll ask one more time, then probably just assume these are fine and appl=
y.
>
> So Conall, have you had a chance to look at these?
>
> Thanks,
>
> Jonathan
>
> >
> > Jonathan
> >
> > >
> > > Thanks,
> > > Michal
> >

