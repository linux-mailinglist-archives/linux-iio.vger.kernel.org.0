Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F323664AA28
	for <lists+linux-iio@lfdr.de>; Mon, 12 Dec 2022 23:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiLLWXj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Dec 2022 17:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiLLWXh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2022 17:23:37 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935CBB7C1;
        Mon, 12 Dec 2022 14:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmWIGWIudoV6nyehsJNvyYWixwZuElUdqY3OOUFBGdB80w9lGEf66qN+8uiwowmL+fyii0SWIpi4wEp7ikioXr0ueHoeHWeqnS2bS5m3+XarjdeIxTnh6PiWJYAmCwzKPt5cZu7no3SBRqQScM2C4yjLc48smNEgRS7g+5YZ8nfG7ziOrYWYsUGALJ9qyhAgTcLu3O7CvOUZCHnBeMl0jhHLcIF6hc3EwPxghP+zzonHskUPtYpnqkwSC8FxH01FW9mEIxN/nNRoDJVHfcpnN+o+3K9tbMTam4t/klR9FhPmNv03dLECdCdNrYT/n0aR1FMhFFLtrmz/p7EQv1XP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRxAGG27YCFbJ+D2Hmo+WzFNQjbSUcjbCTx7RVedWC0=;
 b=IOjFFTOJrjICucMs30mhotU6mttb3lHNXp54OCTzJN6WJXPn0i2KNX9OGrCBwo917eaI751U9C68La1zs4F2+yMzGtDblceyNiiWkaVGnlu6VzUL+ezP4C1Ut2k03p/i3xcPTfnrYwCCovkTV/rLiKtdajGj1+YOW6jHjquUMg/B/6yiWwU2QATgBw3HLh4YwU0awNfK6wPQKua+OTm7eBdD/0vYHqfUbfDl6oolnTkF13VcVXQp8wOD+d0Joj2t2oTjEsBBMrfEi4DE86qwn2kLgDAEX9IKgmwdp7ibGLZza3okTiAsLMpmrGLFipDByhnHBnxy+StGHYlHYlixpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRxAGG27YCFbJ+D2Hmo+WzFNQjbSUcjbCTx7RVedWC0=;
 b=HDDxC0wPwsmnJUTw/XTgHdKs/yYv63plHYNi7/NwnXTqA8oyCpyphNvvkjTnKrlHQB/TLbqW1cHCa3cEajaYDmlkCQ4LNsTHPx2JA4605aCWZGfDkQIDlYR34dK5bVAtcJ3xl6y1B+njNNVvfCsw0VJYyLET80kvWtM/He0xA8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 12 Dec
 2022 22:23:32 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:23:32 +0000
Date:   Mon, 12 Dec 2022 16:23:25 -0600
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/2] iio: accel: add the new entry in driver for
 FXLS8967AF
Message-ID: <20221212222325.jmsg4m4swsqkesus@umbrella>
References: <20221207162045.669958-1-han.xu@nxp.com>
 <20221211130920.47f1c684@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211130920.47f1c684@jic23-huawei>
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AM7PR04MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: a91d1820-8366-485e-538a-08dadc8f80ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQulEuiLHBhK+/q/SsBR0jhLyDHXASNtcXt1ORAV0VXvR2FmSMS34m3ukbYe4fvva9zlfuEkF0FHufSe9/vCn2jtkZYWsHPl+74RJVAuzAWEge89kH6OPiKVj0B0Mn+zlGSKVLRk311dZzpaVYcmIid3Pyq42uhrzwt3AHJjWwCjaBTweAIzb8YBG/FzMUw0Jrap49534imnAjQLxAMv/NjElaAli/OtOqK7msZ3QkHHxIDimuZW3AP2EwoUcyGeXwXSzOJvhVVVjZZGe6YP44RvYaEv80iCEtOUxP1cMqazkjomjHwfwHW9g76GjdLUk8E45iwKijilVRv+XduRSJYO0EAkDSLMlbjjztj7ywsErt9NFoldqN//964RRiiZJawJtK6wUBzhTObRkPDjh+nx/TfIhfil/3AyXBN/aMbAx5iToA0NEEusFYJMmPEriEjc/3+j/XIHG3IFCtziKHmYb8xwaf6PPJ+0wzybbuytBDLrs67c9+H6PVvKnkbu3EGrtv3mLtr8UcpYfOd2HiHbrg9QHD9SkUyQwR0DGtJRkXMF0t5JuJowRYyiqAm2DpRev8o49XsctCzJCfZMUQGdmzTnQ6PDQSMhWykrAIM3BdXHQMD84WlbHMo8aLSBtwDnAKV5EAJdxDnSfClr+9V7pvAwArD95gepyPLGiQnYpERw8jyyqnnI0UyAm/QEh5PxfNtG7sJTKRzYTY8c4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(33716001)(6486002)(478600001)(6506007)(6666004)(2906002)(86362001)(52116002)(38350700002)(26005)(5660300002)(6512007)(186003)(9686003)(44832011)(8936002)(38100700002)(1076003)(66946007)(83380400001)(6916009)(4326008)(54906003)(66476007)(41300700001)(66556008)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fLVjG+lsUOAw6q1EhS5t58IsE0NjA2VXPxgO1v94g4xb0bsDABCo86NYsMG?=
 =?us-ascii?Q?IVraE3qAqc7AG/c7mop30W5mWWWnlch23FOZzqPKTq84Jx5nOGrTr6VOCGCO?=
 =?us-ascii?Q?vRs7imHf4IL5Qz1GtNsmKCBz+fy35MvjQXUHdgcNkbp3n8FmdyIIP8LPau/N?=
 =?us-ascii?Q?IR6pABNMW/RiQhjvpxFkqFEj90bA4mZ45vS91j46mxYzdHb5FgtOj2j1dGZC?=
 =?us-ascii?Q?dYjCYh5yRihBCtGYzdccRYNjOKIJu/Dd1GiRVyxAvkx5VS9cVkOytMLTFS/i?=
 =?us-ascii?Q?3TEp+YlZiE3JF75OHqNECmDCOF+obUDsdl368+lCOlluf5tvTIKajz8aeeaE?=
 =?us-ascii?Q?4IaSKlNORvLTaEy0n2t7H+th4RGC9e6G4X6MIJBvyP0s2P03UU0ISHKlVPvC?=
 =?us-ascii?Q?qOqSmCl3Ce9Wn43s+n4EJBSvw67C8oESSUuAij4HAGuJSgixzeVtiC68fitI?=
 =?us-ascii?Q?pzEOt+r2gIl59A991+ocSwhSjRDgXRECJgyj3ShF0b83GNRQBNKugtNTQkRR?=
 =?us-ascii?Q?QFFV5LVvflz+LLaBowmnj+YhyCDSeLWuXqwBKNgM7715rNuaWLpQg2qiFH/E?=
 =?us-ascii?Q?AsO/oKgJ4amDZBDSLiLcpPKZxq36RSwDBOhjIyrN7LAl2+cEkNwNSRIpTEFE?=
 =?us-ascii?Q?6hEmv4WnLsUWb3I11/k6KeEdzYeMxcXTCsNP38IjDMpXywvs8QQcTGZhCcc0?=
 =?us-ascii?Q?pA/DAVko53Te0gf4q/lxOo8EsXy8aFw6G8KwgmyhX7IkVULZDpkbyUwP6LYf?=
 =?us-ascii?Q?1CPy8SUJmACUpi+DhYw+RcFy35kr2bUMUVRbT9VML7VlpjxODPeatq4pP7kR?=
 =?us-ascii?Q?a15crljYjsuz7H6ZQX9k8+BMs2NKS9hbvmqwk0+Jik92FkkifCn1LHZ2/SjT?=
 =?us-ascii?Q?Hhb/m7ojEeRWF+B3lepc8Dr9aY7lUIHtD/syLhSGTzluadbjgLZM9w8nVbp9?=
 =?us-ascii?Q?lzChnidZGk3wTWBteIhxBImXJUqfOavKUcQ79vizqzCLh1o6refcxqidfKE5?=
 =?us-ascii?Q?cTEZcmY930OalRa0aFn2/V/GjwYjksKHxyCZuCV317nXqa9LN/73o2nS+Hdi?=
 =?us-ascii?Q?3xENZ+M4xejA/ngeVPFpZmDtzBk1ANcsVbwZ6ZeinRPh6uXJ78zclP6u08gv?=
 =?us-ascii?Q?Dc0PfzORhY7yjTuFUS05jXapTO/5sKeX0r/mvbaPVY21Q28l94G84Umb5oJl?=
 =?us-ascii?Q?oO38WVbutVKsvEm4KBpsQ3OS2J21OVPfg4YYOyOoQb6qLVTG4MONmCobNNwU?=
 =?us-ascii?Q?loDmeW7oAK6AjL7s3pqtCQjNPnhr3Ha8i3y1GK9GKrruR4dUprp5abfK+X3M?=
 =?us-ascii?Q?ZNodVNajEBP5wR24naUosCLz+iwN59UTB6vh4A4Ap7XHIkI/SH1GaRNPVTqn?=
 =?us-ascii?Q?YFEvW4pG5qLVUEtX/hfuW5fSZ5Bz3/nLag1uNQoCmIbV3u0NGaDpDp3/Adph?=
 =?us-ascii?Q?EkyDWKiM/iO3BdrqhdxWN2PKJCdZKo1t7JcUm/PhzlOW23iENT7n0r2WQAaP?=
 =?us-ascii?Q?CBHT4e0KCaXFYmRs2+YbsNJXAwVAcPGTidGSFtM9xH0wEoAyrVdMsGq7Fh09?=
 =?us-ascii?Q?R5vWB0suTJFFkrW1udw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91d1820-8366-485e-538a-08dadc8f80ac
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:23:32.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE2FG8RcsIxkMZ9ju1+jvenJWyEO1fnJrySjq8q/eyFNfFqM79P5lFwlWpUEQD8a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22/12/11 01:09PM, Jonathan Cameron wrote:
> On Wed,  7 Dec 2022 10:20:44 -0600
> Han Xu <han.xu@nxp.com> wrote:
> 
> > Add this new device entry in the driver id table.
> > 
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> Hi Han,
> 
> I went to apply this and discovered the FXLs8974CF_DEVICE_ID etc
> isn't yet present in the upstream driver.  Have a I missed a patch
> set somewhere?
> 
> One comment inline.
> 

There is another local patch not upstreamed, just sent them out as a patch set.

> 
> > ---
> >  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
> >  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
> >  drivers/iio/accel/fxls8962af.h      | 1 +
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> > index 17a6f4f4e06c..ddeb1b153499 100644
> > --- a/drivers/iio/accel/fxls8962af-core.c
> > +++ b/drivers/iio/accel/fxls8962af-core.c
> > @@ -127,6 +127,7 @@
> >  #define FXLS8962AF_DEVICE_ID			0x62
> >  #define FXLS8964AF_DEVICE_ID			0x84
> >  #define FXLS8974CF_DEVICE_ID			0x86
> > +#define FXLS8967AF_DEVICE_ID			0x87
> Fine with these being in numeric value order...
> >  
> >  /* Raw temp channel offset */
> >  #define FXLS8962AF_TEMP_CENTER_VAL		25
> > @@ -772,6 +773,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
> >  		.channels = fxls8962af_channels,
> >  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> >  	},
> > +	[fxls8967af] = {
> 
> I'd rather everything else was in 'alphabetical order as anyone looking down
> the lists will expect that ordering rather than one based on IDs that they
> probably won't have reason to know.

fixed in v2.

> 
> > +		.chip_id = FXLS8967AF_DEVICE_ID,
> > +		.name = "fxls8967af",
> > +		.channels = fxls8962af_channels,
> > +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> > +	},
> >  };
> >  
> >  static const struct iio_info fxls8962af_info = {
> > diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> > index 4a755a39d702..fd21f524e04f 100644
> > --- a/drivers/iio/accel/fxls8962af-i2c.c
> > +++ b/drivers/iio/accel/fxls8962af-i2c.c
> > @@ -31,6 +31,7 @@ static const struct i2c_device_id fxls8962af_id[] = {
> >  	{ "fxls8962af", fxls8962af },
> >  	{ "fxls8964af", fxls8964af },
> >  	{ "fxls8974cf", fxls8974cf },
> > +	{ "fxls8967af", fxls8967af },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> > @@ -39,6 +40,7 @@ static const struct of_device_id fxls8962af_of_match[] = {
> >  	{ .compatible = "nxp,fxls8962af" },
> >  	{ .compatible = "nxp,fxls8964af" },
> >  	{ .compatible = "nxp,fxls8974cf" },
> > +	{ .compatible = "nxp,fxls8967af" },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
> > diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> > index 45c7e57412e0..7de924d15694 100644
> > --- a/drivers/iio/accel/fxls8962af.h
> > +++ b/drivers/iio/accel/fxls8962af.h
> > @@ -12,6 +12,7 @@ enum {
> >  	fxls8962af,
> >  	fxls8964af,
> >  	fxls8974cf,
> > +	fxls8967af,
> >  };
> >  
> >  int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
> 
