Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA656C74A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jul 2022 07:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiGIFiq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jul 2022 01:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIFip (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jul 2022 01:38:45 -0400
Received: from mx-relay03-hz1.antispameurope.com (mx-relay03-hz1.antispameurope.com [94.100.132.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BC3A48F
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 22:38:41 -0700 (PDT)
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay03-hz1.antispameurope.com;
 Sat, 09 Jul 2022 07:38:39 +0200
Received: from EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Sat, 9 Jul 2022 07:38:33 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (2a00:1f08:4007:e035:172:18:35:1a) by smtp.eckelmann.de
 (2a00:1f08:4007:e035:172:18:35:5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9 via Frontend
 Transport; Sat, 9 Jul 2022 07:38:32 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQgyyTUoKkajuuhyY09mTg8eQdK/GDpb5fTfI+OX5tZzSiufFv+AY1N5nV/3YWYbzKpM2ALOdVTyZnQIXkcyx0mLJxtT7qIlbEQ4vHHx9+X57jVALYChzlisJ+XZCaZKXLvdycc0WxPkIR+BEXEe2VuOF21vBFL6kEbvuBbBNv3iaiM7qUa+PdWMPgxXaJIrP3d+is6dvoKk/Oe7gIqzJcU5hrEQ8HOtUmgYBS2AeOUfAmA85i+5kva3x7zG4Fkd3yj6MN6ub/V1X8YwKKCthN6GRPik0grmCOsYStrCDuMH+UO9ABTnN7MQRYSeorPS79KphCXCX76tlbQGuSk5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhb1vzAPCYAe9NkGGjYbIre7y8huBZfn4btoJyvcZz8=;
 b=QDGIec/zHX5Xnnv1BvMSJzZNehUeQ7dzoJGW9K0MoTfwONKPq/IVSwm/WRML2TB7EACHXRCfKrqE/4ai5JyNIR5CfEQMLdbSJJul1dLfvsgFFH2Q2D6S+qqNiYBS28cnBXSe/yj7yO+FnO8/Fq9fYUdrhkXXm6Kif4sjusOzLw8VYG9xuVPgtZbj4sFEW8RdpYJvzubHngXYoLUdycEPgo2Z7UGI1pDn2Zkq5Zo2Cvdn+4fPvoX1ZiTQmb8u6rfy/tJgy4NhR6OvrFXn4WuLQe2HGk3t7PLp689esGLE5gQUwJS/p4MG8r+PLAL5/BjlLyDCX3XqVGutg2x7hM0SYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eckelmannde.onmicrosoft.com; s=selector1-eckelmannde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhb1vzAPCYAe9NkGGjYbIre7y8huBZfn4btoJyvcZz8=;
 b=eY2Pl6sdikk3IKA5/ln2Fwd2E9RRxfaj1KF2wcpvQb5w7zB8f0IePNLV7ACEiFEeTTGkIMEh6EQ0f5cc3GfoQiV6KHNpWNEx5AooxYE1BRoG0vT5YYQqntL9JuP/LzAMOKCd40vv6KMuvZEbyS4HJqvWem3z2TH6Smte18P/Evg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2fc::15)
 by AM7P189MB0850.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Sat, 9 Jul
 2022 05:38:13 +0000
Received: from AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::5dbd:b598:df28:90df]) by AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 ([fe80::5dbd:b598:df28:90df%2]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 05:38:12 +0000
Date:   Sat, 9 Jul 2022 07:38:10 +0200
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7949: Fix error message
Message-ID: <20220709053810.wb4mnwk5icjygz4r@NB142.eckelmann.group>
References: <20220708201720.16523-1-t.scherer@eckelmann.de>
 <Ysi07nn5JpIUJHS3@shaak>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysi07nn5JpIUJHS3@shaak>
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:2fc::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d26ae6c-0859-470c-9858-08da616d36c8
X-MS-TrafficTypeDiagnostic: AM7P189MB0850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6KCh0Vkuwa2HLm9sWHs6OCxxVnjbmW+nWkrk9faN7GjB2EhHsYvkCdSsD09KI4qE9tO2ldaEEzTrJid592khJTvghTP8fxnI562kjfmn1fpVHqHCiXUvNP10S6GTy5shZ9j/GL6pqIfjqw6zoDtbS4ir91hMO/7pr1+BOVfHohz5yRMvCJUA1aPzePHJUnX04MboheEbqTOqWrzyAoSoq1gm+DpE7QvmqcNbd+HyA1zQ9LHz26gI6KXOvoru0NyTCtp3YG0NbzXdhm6WaD2fKdBimjYx1r8b4hcFJ7mZ2J4e2QirsiW+hs+Az0L/8MJE+4zQsROuHlbGGEKgVcNJe+ZDmFz/RA2EjWmUM0vi/4uamdw3NPym6OQ4LCIjmZS+4Lj+K7SMA/zIlPHmtPfoDV4erTxHqapohvbsQwnCyu03YycSj8jDrpqkRlsmIMkJM/A1yv07qg7Ou7CkMs3iGI/SxVWZzzDkTc8UdJlI9H8llFSkvuBkyeFLu2+6YVPFb27cqedt0ze3qOQ/xIN4biVodqThmw1kyNWHCObZBj5AC2kjLJF+jBkzIBHHXNeCciUUGu9Wo9QAu6IfID+07HLC8lhbn4fFvL+J+/orOcnBBAKNoia3B/p8vBbeCok5mrfysAM4Mb1ouT2ad772wviecHSFAjz3QStWHQK40GF33vAj8Y1gI+RrdYJHV0MgCJ/Fun2Ba1dh938a0VAkR+yrKRjV1ex/JTS63m/hKdfGcxTB6jspR+ieTQrjFnl+5EoFcyzqEXeIDUJZltVhia0uJAw35FtniGiDomlBfPf0pMMUSAo0pvKE4ft2dxR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1700.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(1076003)(52116002)(26005)(9686003)(6512007)(2906002)(5660300002)(8936002)(478600001)(41300700001)(6506007)(6486002)(83380400001)(186003)(6916009)(316002)(38350700002)(38100700002)(86362001)(66946007)(66556008)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+o+lcQZHPdX4B0ng0/LGSLSfLbID8AoxMDAA0/zrHSRDOABBId5N5pdf0pYY?=
 =?us-ascii?Q?WYAVLwMYW4E4Zfvt+uGkyJOY5WIvsRIdSLVLUNVDvpY1lDy0P7wICFBO5irV?=
 =?us-ascii?Q?6NedXZBDti3oxaPUywZFnnG11X7Py706Y5SHp7ozMopMv0UDG1GM96funAHG?=
 =?us-ascii?Q?f8JmiJiQbjsNjinEIwUN6+/eAAy4dmlIT9jWmLCTAhTR/ADKj8ApVyW/0sXE?=
 =?us-ascii?Q?0J5uFGDnxNWmTxpWHdz/Gse4N9oDx0/NKbTQmb7PEqQ5KEwpoWTCQJTXhSU/?=
 =?us-ascii?Q?NM+vGddw0k3t+C7ZurjdLQSneWFMJ6XOLGvLMiMVKFOGNwBRgO/0JUm+qUez?=
 =?us-ascii?Q?c5VFZ1Gag1JkM5+pBenl00RqoSCD/xbbMYXgTpVrBp7PWS1au0ser1wWGnb2?=
 =?us-ascii?Q?rHjjLCR3ugzrFeChvwUYELReIFKBIe2I4FqDT7Vi0tekEeojWocaSoPpluRW?=
 =?us-ascii?Q?Hcr74ULDdm63u83KZAjIUEry06X9TswzXgckiM/N3rrwVV0cnAcKVhjmtzVK?=
 =?us-ascii?Q?e1FVCR+y27iWy+PtZKp2RWTRjKVT9apIW8Tk6oWEtpUcjc9a3LRJpi8YGAFK?=
 =?us-ascii?Q?sSiLttVs/knrPzPe4TDWnwIIurb5y2rc9qrrcqyYl//sYIzGr3Y1jkyuowGN?=
 =?us-ascii?Q?pO6I7VSCDxkkHO17z+v7uqHlveYrd8qnO7x3380pF1u1ix2MtHRDtOkqJfrs?=
 =?us-ascii?Q?Jl77of5z1In4kxX2fFBbqJzC/qTXuHscuMYdMSWKgUfSuzRSQVMpuXFevnRA?=
 =?us-ascii?Q?pSKnE7AL149GBMlc/J4+GUzkz8Npk00k/vxo1PgIxp/SbckeY0b3FA8S/iQ6?=
 =?us-ascii?Q?9lNf4B7/d++gIN52mp7+7xcOyEesAatxavYjCaXE5nGtqbPca1jjAmQq5VTH?=
 =?us-ascii?Q?NARbC5jZD4W2V9uuCcWE16oFZ+F/pjGaqfnBb4jbJlqBIlWD7TPZTIa1aGhk?=
 =?us-ascii?Q?A2q2RI4m55fPZ+8uzo3AuMoUHySwb35ZhDrhiiBi8eJWC4Vs/j6EpPElElKX?=
 =?us-ascii?Q?wGROV+P8Vi4UAeX/pJVj0S6XOvCNpLnb9i/H/X1lvdZRflt5AGFnVi/rbs3D?=
 =?us-ascii?Q?lUbJ2rYO2gHTRRDBTynl7MowYS9YBDXvBl5Suz8M54iStO/39ZzCK5i3kVYC?=
 =?us-ascii?Q?5sTGDraN9lsMLP/gnDPG5cZZhgjM26cVp+KPcEcA7jXfeyOS2Cmhsx/Kul8y?=
 =?us-ascii?Q?3AlBOyTiM1m88Eb8NPY2pGz/Ys0kxnbEaKzTLWtbGMT5503mCupdV6XySP9E?=
 =?us-ascii?Q?bvdoNNXi3i0e2Yz/BDnj4UkaRcl4SABl0FKxg3WJwlu1c0IqAof/jbeFmMUD?=
 =?us-ascii?Q?s3vSO5be4amJwB0m0vH1HkBLX7kAW5SAVu9HWclI6KtNeMgxfu7vfx9JGhtR?=
 =?us-ascii?Q?/keFqv3mLF7RZcCRcAhCFkVTjyC53sCBJYhJwIe67seS6+pad6hPpyIJxHDS?=
 =?us-ascii?Q?MiE59/6KOKWRMEsgfj/UiXKj53PHyErzwoe8jvHWjt/tDhx7WP3+SfomX0we?=
 =?us-ascii?Q?sz6CgOj/IKET/TS1QPJMKrfHAvh3TIo//Pbh4oYxrYRvpnajrt3JVbHQtiHb?=
 =?us-ascii?Q?GYy5a+yOda+5+EXD8/GtazcTENJmCYo6IMuB7y96GH6fyRXv2/H+p9NaW87d?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d26ae6c-0859-470c-9858-08da616d36c8
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1700.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 05:38:12.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SINwRzq5+8evUdfUul+Hc/avoC8lhS8oo6rpo+WKUr/iC2WeqxLkXJz2o17Ma02lvlzW/U2C8R+RcTcqBz7syg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0850
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-iio@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay03-hz1.antispameurope.com with 7519EC057E6
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security-Digest: 921b640be855588ab5e04e4f2f7b70d2
X-cloud-security: scantime:1.517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=hse1; bh=u3WoBmtGzTb6TSQmanKeqsYCTG
        ZTk+sjvk1FAJrX9M4=; b=fX8dWUpoa7CuiR62+dK+N+gxPzHpl7ITyEQb01xalE
        0bvskOZp561451zvKs/cnUq1Y6C+cxITI0BCVsTh5lUTXPFQsT3kcu3Oef9Vn9TY
        WkHL5rN231Ol9BMUMNBkGBv9HL5Ihl/5Ishosh+mozAOSafK9zcfGNkdax6BLgiE
        9Ee03CFjyfFqZ7rduyw5mtYLVugGqWkhMtnOod0ND8p+Qoy53hYCdQzcaK00mRR9
        XwTx7cd/ElIVM38/brzO5pVIP7ActE2VUJHzhWx8xi6EfeLNGQfVXZfu7Iw69sZp
        x5MMV+g43dl8c7gWxnRggR0AjJTuG21afU9lowmwyOkQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Fri, Jul 08, 2022 at 06:51:26PM -0400, Liam Beguin wrote:
> On Fri, Jul 08, 2022 at 10:17:20PM +0200, Thorsten Scherer wrote:
> > Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> > ---
> >  drivers/iio/adc/ad7949.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 44bb5fde83de..12fb5f9971db 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -400,7 +400,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
> >  
> >  	ret = ad7949_spi_init(ad7949_adc);
> >  	if (ret) {
> > -		dev_err(dev, "enable to init this device: %d\n", ret);
> > +		dev_err(dev, "fail to init this device: %d\n", ret);
> 
> Maybe 'failed' or 'unable' instead of 'fail'?

I decided to be consistent with the wording of the other dev_err's.  If
anyone cares, I'll send a v2 adjusting the others as well.

> otherwise:
> 
> Reviewed-by: Liam Beguin <liambeguin@gmail.com>
> 
> Cheers,
> Liam
> 

Best regards
Thorsten
