Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58C1DF41A
	for <lists+linux-iio@lfdr.de>; Sat, 23 May 2020 03:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgEWBx4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 21:53:56 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:25642
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387438AbgEWBx4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 May 2020 21:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTNzUUw311J2n9cIsGKxlTBZju56fgxWM0ltOpRrV0FxDqQdDIAuMWhT4AptFR3qJmkWbNFC2Mbc02BhkJvK9EZatVwE7caS3lMNXtlUOwd68Me0jICXFy78TwNnT+G9HFs8hj3RdGm8VEwstHDAID01rrfPvurdTtg2B9EvVDYV4B0X37lB8zjHfi9Uygf/7REPECzF/M1KpoTcl7fb6AWd/RhePZgAIg7EZX2TU3pWtl5vsDp/KV6Mrn49BAgaboHSSy/zWvYeFzureLUmQY94bvbIq2meBmYLYN58GrMlVfGVaHiWN3EvrljUS/4HYQ0+UjThu+sqvjRBiA+H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY2W3vXmK9FnBhx0cmy9lw3EtSwGZBcSHpZ5st6t1fU=;
 b=Zmq7Ryguxr9kjH1FPO7oo3WtTuVWCV0Z/BUUefs3EXr28e6k1rYcxii+UGaDcahiQex8OLfFxWggIzl2TEQUnIlntaA+WzSWMlecHwm8AOd2J30m5nSi9FaScNmaPUlCrfKYqIC+Yfjd+omGHZs3ekpXC8viZGRfNR3V2zn+lEnmwTW8Vq1uCfhjeMreX0Tqt3cGed+F92fAx74/9vd36/N578Ag3YYwe8m4BYqhG324B0Zpa8Y82+WdyilNHuMorrFa3gipfwlnP2RV6fUi0kwRvYxB0pNivza2tR6euCiE/gf8cOrPDfd0cj4/2/3slCEZKYJPcuXOKkC5G1ED/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY2W3vXmK9FnBhx0cmy9lw3EtSwGZBcSHpZ5st6t1fU=;
 b=rvoSyXDgPFjKJkYJmYf13Isa3JU2q3lpM42ttF37oc+4L4LqE9SajbUfkPFjRWrCrphI0lauqa2nhYDa7U7jQDuFBNOx8DiopRKAbWOAiKguPKSf7EkFhVIf6iREOWUgY0/hhtQ2bEQZnBEmhdn2SO2vU/4hvq05OQ8eRKek7PA=
Authentication-Results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB5359.namprd08.prod.outlook.com (2603:10b6:805:92::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Sat, 23 May
 2020 01:53:52 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::d1f2:9197:cd6:4823]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::d1f2:9197:cd6:4823%7]) with mapi id 15.20.3021.027; Sat, 23 May 2020
 01:53:51 +0000
Date:   Fri, 22 May 2020 20:53:40 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org
Subject: Re: [PATCH] iio: position: iqs624: remove usage of iio_priv_to_dev()
Message-ID: <20200523015340.GA2690@labundy.com>
References: <20200522065322.9611-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522065322.9611-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: DM6PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:5:18f::25) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Sat, 23 May 2020 01:53:50 +0000
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda80190-ce0a-41cc-d8e7-08d7febc2459
X-MS-TrafficTypeDiagnostic: SN6PR08MB5359:
X-Microsoft-Antispam-PRVS: <SN6PR08MB5359B49FBC7098053B530867D3B50@SN6PR08MB5359.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0412A98A59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FW+YhRMHwBsK5/JJFPQGWPayCFIpeVsbpmnRqwAm90QUHx7tOaJBj3woP/S1TdV4XbIN1csleJX1PI4qGDcMIpafx6PnHrPnPWVdz/UJxsviczjweatxtxrf7P728DBIRdmzeA2cMyfev6LaFPkjWiWBU9rHlWqEuIuM5ZynVFMUWvoKfSNsICInkGbvO+O2GKZkmTN3ajh0QH0G4XbVBXOrO5CfT8afhvWM0h+7zyetQ28ek8J4OFXuKF7ry4+G46FoY00UFsQ6sm9Ephjgh1wKwYAfKUKBgn7DYW1A0TOd1UbE4XBxjtkEirADUrj5PP6zaF2BReA2CenbqVgBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(136003)(39830400003)(396003)(26005)(66946007)(316002)(16526019)(86362001)(7696005)(66476007)(33656002)(186003)(66556008)(5660300002)(1076003)(52116002)(55016002)(508600001)(2616005)(6916009)(4326008)(6666004)(956004)(8676002)(8886007)(2906002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S2i+jSm/mYt5HLOvP2HtCA07lj2UhFPDWDEqNtItlYBflezk05Cx/Jm5pC3ajW7oLwpOZGqqi2N3livN+NdWzNwyckdKLLg3iOkaQvEoRfybC/1q2YWsA/Hq5Xpqp8HYomK4vCdBm3ksuQjK57+6oxkih+QlfZ7m19uO+XjISDiULn28bX+l1ltH/zrxFjPXIcrQU28GOV4ZXZl0tvZZJKwUEfALr07waHYkmwEUTleWqWNwtKFlVxMZvTjjQeOmeAmYkZluz3a29c8TjXyp4OpX748B+B6BXjaSRqD7a0diZjRDf+8MHWzjS3lu+YSwztiv08UyATgDUWRQ6YnSZxj1RWRSIHyT0okGewcRcaybSHw//hTd532C/ddVJ/QBfNTfk+tDEWsbRPeiF2hfww9l6EdySv08KnWGITuvmuUT5U8rW1zY7GlJc9FIv5jOk/i2QB5UrSzK1NqK0MK040aZEtdQf9IakfFwrAHPfXQ=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda80190-ce0a-41cc-d8e7-08d7febc2459
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2020 01:53:51.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE3yDB2FsYAeLmWNew37RPgSTQXlOTtffc+GNIlwOrsQbGH4gc/q47/R4h43n7v9j7ZKRAYttW3xCEAXTSMBLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5359
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

On Fri, May 22, 2020 at 09:53:22AM +0300, Alexandru Ardelean wrote:
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
> For this driver, removing iio_priv_to_dev() also means keeping a reference
> on the state struct.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/position/iqs624-pos.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

As a customer of iio, I find it handy that there is an "inverse" to iio_priv.
In this particular case it saves the container iio_dev from storing a pointer
to itself.

That being said, this patch is perfectly fine and I have no objection if this
is the route you and Jonathan opt to take. And so:

Acked-by: Jeff LaBundy <jeff@labundy.com>

> 
> diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
> index 77096c31c2ba..520dafbdc48f 100644
> --- a/drivers/iio/position/iqs624-pos.c
> +++ b/drivers/iio/position/iqs624-pos.c
> @@ -23,6 +23,7 @@
>  
>  struct iqs624_pos_private {
>  	struct iqs62x_core *iqs62x;
> +	struct iio_dev *indio_dev;
>  	struct notifier_block notifier;
>  	struct mutex lock;
>  	bool angle_en;
> @@ -59,7 +60,7 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
>  
>  	iqs624_pos = container_of(notifier, struct iqs624_pos_private,
>  				  notifier);
> -	indio_dev = iio_priv_to_dev(iqs624_pos);
> +	indio_dev = iqs624_pos->indio_dev;
>  	timestamp = iio_get_time_ns(indio_dev);
>  
>  	iqs62x = iqs624_pos->iqs62x;
> @@ -98,7 +99,7 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
>  static void iqs624_pos_notifier_unregister(void *context)
>  {
>  	struct iqs624_pos_private *iqs624_pos = context;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(iqs624_pos);
> +	struct iio_dev *indio_dev = iqs624_pos->indio_dev;
>  	int ret;
>  
>  	ret = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
> @@ -243,6 +244,7 @@ static int iqs624_pos_probe(struct platform_device *pdev)
>  
>  	iqs624_pos = iio_priv(indio_dev);
>  	iqs624_pos->iqs62x = iqs62x;
> +	iqs624_pos->indio_dev = indio_dev;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->dev.parent = &pdev->dev;
> -- 
> 2.25.1
> 

Kind regards,
Jeff LaBundy
