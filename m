Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95131EB81
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBRPZj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 18 Feb 2021 10:25:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2583 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhBRMRE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 07:17:04 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DhD7d6sR5z67pfY;
        Thu, 18 Feb 2021 20:10:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 13:16:06 +0100
Received: from localhost (10.47.67.19) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Feb
 2021 12:16:06 +0000
Date:   Thu, 18 Feb 2021 12:15:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Ekin =?ISO-8859-1?Q?B=F6ke?= <ekin_boke@arcelik.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "cengiz@kernel.wtf" <cengiz@kernel.wtf>
Subject: Re: Control Register device tree binding request for Opt3001
Message-ID: <20210218121502.00002014@Huawei.com>
In-Reply-To: <CA+U=DspfyuxyhPfPrGDaU5nDQVaO5p3ha-5hwpzVX69p1P60WA@mail.gmail.com>
References: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
        <CA+U=DspfyuxyhPfPrGDaU5nDQVaO5p3ha-5hwpzVX69p1P60WA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.67.19]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Feb 2021 10:35:27 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Feb 18, 2021 at 7:27 AM Ekin Böke <ekin_boke@arcelik.com> wrote:
> >
> > Hi,
> >
> > We are using Opt3001 for a day light control system and according to the data sheet it has 2 conversion time modes
> > that are 100 ms(CT=0) and 800 ms(CT=1) . Configuration register field CT controls the conversion time and we want to set the CT parameter at the initialization to 0 at all times. We could do it by using the in_illuminance_integration_time sysfs node at the runtime.
> >
> > Should we add a parameter to the device tree bindings or is there another way to set the CT parameter at the initialization?  
> 
> It's usually a good idea to use the sysfs attribute, if it's already available.
> Maybe during system boot-up, you can add some service init call to
> initialize to 100 ms or right before starting to read data from the
> sensor.
> 
> For kernel people, these initialization device-tree attributes seem convenient.
> But in this case, CT is a parameter of the chip and not a hard-wired
> configuration of the board [which needs to be described in DT].

As described, what you want to control here is policy, not a characteristic
of the hardware.   Normally we don't use DT to make such decisions, as it should
be controlled at runtime.

So basically what Alex said :)

Jonathan

> 
> >
> >
> > Best Regards
> >
> > Ekin
> >
> >
> >
> > Bu e-posta mesaji kisiye ozel olup, gizli bilgiler iceriyor olabilir. Eger bu e-posta mesaji size yanlislikla ulasmissa, icerigini hic bir sekilde kullanmayiniz ve ekli dosyalari acmayiniz. Bu durumda lutfen e-posta mesajini kullaniciya hemen geri gonderiniz ve tum kopyalarini mesaj kutunuzdan siliniz. Bu e-posta mesaji, hic bir sekilde, herhangi bir amac icin cogaltilamaz, yayinlanamaz ve para karsiligi satilamaz. Bu e-posta mesaji viruslere karsi anti-virus sistemleri tarafindan taranmistir. Ancak yollayici, bu e-posta mesajinin - virus koruma sistemleri ile kontrol ediliyor olsa bile - virus icermedigini garanti etmez ve meydana gelebilecek zararlardan dogacak hicbir sorumlulugu kabul etmez. This message is intended solely for the use of the individual or entity to whom it is addressed , and may contain confidential information. If you are not the intended recipient of this message or you receive this mail in error, you should refrain from making any use of the contents and from opening any attachment. In that case, please notify the sender immediately and return the message to the sender, then, delete and destroy all copies. This e-mail message, can not be copied, published or sold for any reason. This e-mail message has been swept by anti-virus systems for the presence of computer viruses. In doing so, however, sender cannot warrant that virus or other forms of data corruption may not be present and do not take any responsibility in any occurrence.  

