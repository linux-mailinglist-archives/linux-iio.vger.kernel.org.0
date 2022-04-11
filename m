Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A694FB646
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbiDKIrO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiDKIrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 04:47:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A93A182
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 01:44:58 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KcMlp37rCz67ZJR;
        Mon, 11 Apr 2022 16:41:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 10:44:54 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 09:44:54 +0100
Date:   Mon, 11 Apr 2022 09:44:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !y
 and improve readability
Message-ID: <20220411094452.00001fd1@Huawei.com>
In-Reply-To: <CY4PR03MB339994ADA257E9EA436FD8129BEA9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220319181401.136810-1-jic23@kernel.org>
        <20220410181628.084fcf3b@jic23-huawei>
        <CY4PR03MB339994ADA257E9EA436FD8129BEA9@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Apr 2022 07:18:10 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, April 10, 2022 8:16 PM
> > To: linux-iio@vger.kernel.org
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>
> > Subject: Re: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !y
> > and improve readability
> > 
> > [External]
> > 
> > On Sat, 19 Mar 2022 18:14:01 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > The warning comes from __BF_FIELD_CHECK()
> > > specifically
> > >
> > > BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> > > 		 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
> > > 		 _pfx "value too large for the field"); \
> > >
> > > The code was using !(enum value) which is not particularly easy to follow
> > > so replace that with explicit matching and use of ? 0 : 1; or ? 1 : 0;
> > > to improve readability.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> > 
> > Antoniu, or anyone else who has time, can you sanity check this one?
> > I'd like to clean up the warning asap but don't really trust myself
> > enough to not have done something stupid ;)
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/frequency/admv1014.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/frequency/admv1014.c  
> > b/drivers/iio/frequency/admv1014.c  
> > > index a7994f8e6b9b..802835efbec7 100644
> > > --- a/drivers/iio/frequency/admv1014.c
> > > +++ b/drivers/iio/frequency/admv1014.c
> > > @@ -700,8 +700,10 @@ static int admv1014_init(struct admv1014_state  
> > *st)  
> > >  			 ADMV1014_DET_EN_MSK;
> > >
> > >  	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK,  
> > st->p1db_comp ? 3 : 0) |  
> > > -		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st-
> > >input_mode)) |
> > > -		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st-
> > >input_mode) |
> > > +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
> > > +				(st->input_mode == ADMV1014_IQ_MODE)  
> > ? 0 : 1) |  
> > > +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
> > > +				(st->input_mode == ADMV1014_IQ_MODE)  
> > ? 1 : 0) |  
> Hello Jonathan,
> 
> I think it should be vice-versa:
> 		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
> 				(st->input_mode == ADMV1014_IQ_MODE) ? 1 : 0) |
> 		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
> 				(st->input_mode == ADMV1014_IQ_MODE) ? 0 : 1) |
> 
> "To set the ADMV1014 in I/Q mode, set BB_AMP_PD
> (Register 0x03, Bit 8) to 0 and set IF_AMP_PD (Register 0x03,
> Bit 11) to 1."
> 
> "To configure the ADMV1014 in IF mode, set BB_AMP_PD
> (Register 0x03, Bit 8) to 1 and set IF_AMP_PD (Register 0x03,
> Bit 11) to 0"

And that's why I need sanity checks on 'obvious' patches. Thanks!

You are correct that I've inverted it by matching on the 0 enum value,
whereas the original code was effectively starting with the 1 enum value.
Keeping closer to the original code it would be:

 		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
 				(st->input_mode == ADMV1014_IF_MODE) ? 0 : 1) |
 		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
 				(st->input_mode == ADMV1014_IF_MODE) ? 1 : 0) |

I'm tempted to go with that version rather than your equivalent one because
it keeps the sense of the statements the same so in theory should be a more
obvious patch.

Will send a v2.

Thanks,

Jonathan

> 
> Regards,
> > >  		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
> > >
> > >  	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE,  
> > enable_reg_msk, enable_reg);  
> 

