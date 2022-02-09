Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A533E4AF3AA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Feb 2022 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiBIOHf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 9 Feb 2022 09:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiBIOHe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2022 09:07:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB3C061355
        for <linux-iio@vger.kernel.org>; Wed,  9 Feb 2022 06:07:37 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jv1s71xH9z67wr8;
        Wed,  9 Feb 2022 22:06:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 15:07:34 +0100
Received: from localhost (10.47.75.34) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 14:07:34 +0000
Date:   Wed, 9 Feb 2022 14:07:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: IIO driver/datasheet question
Message-ID: <20220209140730.00007842@Huawei.com>
In-Reply-To: <CY4PR03MB33991EB004B66FE32A39F2F19B2E9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <CY4PR03MB33991EB004B66FE32A39F2F19B2E9@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.75.34]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Feb 2022 13:24:25 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Hello,
> 
> Is it acceptable to send an IIO driver (ADA4250 Programmable Instrumentation Amplifier) upstream without having the datasheet link available?
> 

yes.

Though the disadvantage is you may well get a lot more questions
as reviewers won't be able to check things for themselves. Also
might get asked to add more documentation for places we guess there
might be questions in future.  So review tends to go a bit slower
when datasheets aren't available - hence it's great when the are.

Jonathan



> Regards,
> -- 
> Antoniu Miclãuº
> System Applications Engineer
> Customer Solution Enablement
> 
> E-mail: antoniu.miclaus@analog.com
> Mobile: +40 747 036533
> 
> 
> 
>                
> 
> 

