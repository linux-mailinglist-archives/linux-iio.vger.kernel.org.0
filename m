Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DCB1DF41D
	for <lists+linux-iio@lfdr.de>; Sat, 23 May 2020 03:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgEWB4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 21:56:42 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:6263
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbgEWB4l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 May 2020 21:56:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsUMG+MNxZHVAXPyl08w4JwKdqaSUvJkdxRLu8rcV1UVZMI5Oz9yoOhits+cSoIWAkjdJ3O5cpewgb6OMbrW8eFRRKfc5mcYw6QXpf04sB+z2Bg81zUnCP6zt0/NIdtfpO6IlhhLW2R4HacDDYPGq9+lupZU4QCYiwi8deBEsyRE80U+PIuWDxOjxb3Es0DKUTDVTruTiypI/m2jZxXNbcPF6bjiJnCsdNPHacjoAwPUGtVYYZDJTdrw2uj+jS/p/BhKkaFtIkDNPtSgQRsvGXJNuNfxmSE5GN7V/tFWsEyEZyStRQ1s29s49CE/xL0a2W3k/ZHdKvOg609G6kTnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv4GA5OS+X9dr8N1hxe4o8ug4PNRukYcEy+Dbf0QgTg=;
 b=hU0ZdTKCgib9lhR54NocGdEQXo3MwQWr0YpZvMxf8spb9FWYcoRzZKtEvjijP9F3L+CnfpESY0Lt7yRLn251lf4ZfBSGxYs8udSZoZQ29wWNj4n5lsEN7WmMjyxweMvpnVdUBoDFjofg2xhA1j5yhZQQ2ZecFaExg8Qwp/sxJs51DL8pY+oAO66E7XRDY1eDUU9YjDyLSmDQ2n5teNAJdkyouI+xBduPmu1GOCtImxL2PGM69I+n3om+YZXt5E2DaEp3M4H5S/Ytgn1WI2kgobdTw0GwJ6k56xs1ymqBGXfvm1tfF4n7JJzQU3PScxUiMVeNf7fGGe6w78EXImbjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv4GA5OS+X9dr8N1hxe4o8ug4PNRukYcEy+Dbf0QgTg=;
 b=gbDReYV+b/J6dLT+OOQF9QXMjxUe6nBdirmCkzuTwrWljNr/z7tM3xZ1Us9QCebmkKJ7DNPXO+ePgAzfF88XFCXrWgn8mSq5jMRo2EAQbbmi5NFar+zshn6mFxG3+zjb88NGqi+kdwBccAQzTX3kIn8Oh2PBMw50m5h8XNWlJYk=
Authentication-Results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB5021.namprd08.prod.outlook.com (2603:10b6:805:6a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sat, 23 May
 2020 01:56:38 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::d1f2:9197:cd6:4823]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::d1f2:9197:cd6:4823%7]) with mapi id 15.20.3021.027; Sat, 23 May 2020
 01:56:38 +0000
Date:   Fri, 22 May 2020 20:56:35 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org
Subject: Re: [PATCH] iio: light: iqs621: remove usage of iio_priv_to_dev()
Message-ID: <20200523015635.GB2690@labundy.com>
References: <20200522065442.10203-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522065442.10203-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: DM5PR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:4:16::29) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM5PR2001CA0019.namprd20.prod.outlook.com (2603:10b6:4:16::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Sat, 23 May 2020 01:56:37 +0000
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33553fae-870b-43e6-f1a5-08d7febc8798
X-MS-TrafficTypeDiagnostic: SN6PR08MB5021:
X-Microsoft-Antispam-PRVS: <SN6PR08MB5021A72E6A79E1B5AE2A5E00D3B50@SN6PR08MB5021.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0412A98A59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9d0eBihoUWlps+n334Y97rbsD8S8imUspuW36N2lPGMWLlJ1Xc1lqv3nOG6cuumuEPsIbRPOYxDVdj5/s8W88wnMnnKGQh9MwfgXo31oKyCijtP7SCNjI3Ua16+0AolDTzw6WmlXIjLgcXWMBytUuWBQbLvz2OUms5DeYI+4oAyI0OvR4mpqS8En0lZOeg3whESQWmHNWOgK/+QR6LEOTkLAoh3pHo2c/aB0Y4tSgxkRoK9Y6scVgI7+nq4PI8PuOzI9qD/ZJzlHe+QJedG+o0tZC+1kN2xpA4FBBoOArqxXBg+szOkTk2/yPxKrSvhLtLj0axCUZfv+zRfz5CYEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39830400003)(366004)(396003)(55016002)(4326008)(956004)(2616005)(8936002)(26005)(33656002)(36756003)(2906002)(52116002)(7696005)(66946007)(66476007)(66556008)(1076003)(508600001)(6916009)(8676002)(316002)(186003)(16526019)(86362001)(8886007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: E0Bth0efrfA8xjCtfQZuY7yVHcSEoQ8xMn9Mv8wuVH/xkO0W6VU/aVTMWng3naxb3PdwOzDV/2Sfa3kOcy630dcfvHzKw/bG/M8bF1WSMt4wHA8hCg6HwpSjWzccX+pHVhR1LslLpocs8/0BzR1693veuUDbwe79diOQGrQV87+8KZLoeURRvt0n52e/2VM967LPNgb+Bd4VI6ssJFnKYezxtFIVZYXOPTI5OMfAofMIwQXbimi6U6BVnBgc5iyc8NJInBe35gOcRHviKm4/TIhzDmaWM0M//BoGem0F6gublmcA/whI2eMAithP/AI0UzCbInNKYTM2CovJ2WcHHvSbUozTYg3Mmoece/KhD/TC5ITQ8RLcs3RjXVsp1x2JDeIaOK5kOxRFyLHSVtEOxwU7rtjtIEOgDKFSJVfIvy4XKTrtvCENbDN3+h4yrfp5N3Uy3KTcI1dfe+k/04NIsIeh+apUOjig1vFPVmvimlc=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33553fae-870b-43e6-f1a5-08d7febc8798
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2020 01:56:38.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XS984DsGGiY6Ykh1LSRppPAeuDggU995jAyhARCTCOcbqP63jRZWLFA/SlA3x7lJ8+ZvDSMYQqo3hu6aaJi3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5021
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

On Fri, May 22, 2020 at 09:54:42AM +0300, Alexandru Ardelean wrote:
> We may want to get rid of the iio_priv_to_dev() helper. That's a bit
> uncertain at this point. The reason is that we will hide some of the
> members of the iio_dev structure (to prevent drivers from accessing them
> directly), and that will also mean hiding the implementation of the
> iio_priv_to_dev() helper inside the IIO core.
> 
> Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> may not be fast anymore, so a general idea is to try to get rid of the
> iio_priv_to_dev() altogether.
> 
> For this driver, removing iio_priv_to_dev() means keeping a reference
> on the state struct.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/light/iqs621-als.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

As with the iqs624 patch:

Acked-by: Jeff LaBundy <jeff@labundy.com>

> 
> diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
> index b2988a782bd0..1a056e2446ab 100644
> --- a/drivers/iio/light/iqs621-als.c
> +++ b/drivers/iio/light/iqs621-als.c
> @@ -36,6 +36,7 @@
>  
>  struct iqs621_als_private {
>  	struct iqs62x_core *iqs62x;
> +	struct iio_dev *indio_dev;
>  	struct notifier_block notifier;
>  	struct mutex lock;
>  	bool light_en;
> @@ -103,7 +104,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
>  
>  	iqs621_als = container_of(notifier, struct iqs621_als_private,
>  				  notifier);
> -	indio_dev = iio_priv_to_dev(iqs621_als);
> +	indio_dev = iqs621_als->indio_dev;
>  	timestamp = iio_get_time_ns(indio_dev);
>  
>  	mutex_lock(&iqs621_als->lock);
> @@ -191,7 +192,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
>  static void iqs621_als_notifier_unregister(void *context)
>  {
>  	struct iqs621_als_private *iqs621_als = context;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(iqs621_als);
> +	struct iio_dev *indio_dev = iqs621_als->indio_dev;
>  	int ret;
>  
>  	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
> @@ -551,6 +552,7 @@ static int iqs621_als_probe(struct platform_device *pdev)
>  
>  	iqs621_als = iio_priv(indio_dev);
>  	iqs621_als->iqs62x = iqs62x;
> +	iqs621_als->indio_dev = indio_dev;
>  
>  	if (iqs62x->dev_desc->prod_num == IQS622_PROD_NUM) {
>  		ret = regmap_read(iqs62x->regmap, IQS622_IR_THRESH_TOUCH,
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
