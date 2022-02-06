Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E764AB124
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiBFSCe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiBFSCc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:02:32 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C586C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:02:31 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso9438009otv.13
        for <linux-iio@vger.kernel.org>; Sun, 06 Feb 2022 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crPGINHId+keQOABh5fg5/iKw2F6keQL4AY1/ITIHd4=;
        b=Q+JitQuwxAaueCOfGdQYfQTzJcrBbnBPhsh8QokzaU1nsWrMW6X0PAfQL732cE+pN5
         aVGP3ZvTN0OUVT2tiEAo7S6N85pKVa13mCb7JZh8kfUQKG+qOqBpo2Nl9arj3XUsJ6I9
         GPy5HqTQje43E6I/L+Al62bu+ixkCJCOuNk2tvhzMyVT9adCydz9oPkuRm64+6zzbkWF
         YJa+vLc9vwr3Bj4DB8mvPo3MN0X/JfnMoBx//3fuN+UcL5FViVuoE5Pa8FAmtFpXyOeP
         orweE8an7AncvygvH0nucKz9M5XXFPalFyy2BJQtIXe2DXReZi1JG9g0hMaILPFgnVCA
         faGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crPGINHId+keQOABh5fg5/iKw2F6keQL4AY1/ITIHd4=;
        b=UNBdFVREkkmaYCMhRPKzO3k3Hawjc5ZTtz2G3ovSbX1N+FA3EMO3LrTC7ypdBf70a2
         D3biA4TbRP7NzNfjSLC3O/yEWrKva13KCmhlfZdt6xVb7ZPSIVwE6NoKn5RjfstnZLki
         4izhiUHdM8StI9kPpHYhaKMFABT9DX8sSgC8l8WMiWqA0paeiUiBnwrrMSpaPH/0UnM5
         zu1qHSL1gGsAKqr4Dipk2u/gmBVHf1jZtF/13wlg6YANpJMGl8d/FnXok/lFdbJ0KE6Y
         qM5OgQnQTIYQJfoIOd4hdT5cRmklhpB0bCdhB/vyiEfytHhhE8c9FCUVZfWXuLsRzFDc
         KCRQ==
X-Gm-Message-State: AOAM533yhXJE/U9oiyUN40Pi96d4QdTmAD2SzG7MPfEXD5nfdPPtjSfb
        H2jQabMQ9R/bHz7uALpNhratkpFjhAk=
X-Google-Smtp-Source: ABdhPJzvG1qFeE/AK7FazKsuFxJzBz40g5U1tmE5rx+45mFVHyP9E+CW6Xa0brIFKtSFCNabOWYoXA==
X-Received: by 2002:a9d:d72:: with SMTP id 105mr3012938oti.340.1644170550773;
        Sun, 06 Feb 2022 10:02:30 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b7a:7b00:70e:e3d5:be94:991])
        by smtp.gmail.com with ESMTPSA id bc36sm3091827oob.45.2022.02.06.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 10:02:29 -0800 (PST)
Date:   Sun, 6 Feb 2022 15:02:26 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/17] staging:iio:adc:ad7280a: Use bitfield ops to
 managed fields in transfers.
Message-ID: <YgANMrabk3L5W4kE@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-6-jic23@kernel.org>
 <YbjQeDekwU1wTdrF@marsc.168.1.7>
 <20220206171454.7be8dd34@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206171454.7be8dd34@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/06, Jonathan Cameron wrote:
> On Tue, 14 Dec 2021 14:12:24 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Minor bit inline.
> > 
> > On 12/05, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > The write and two types of read transfer are sufficiently complex that
> > > they benefit from the clarity of using FIELD_PREP() and FIELD_GET()
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> Those hunks you highlighted in patch 2 now in this patch and I've added a note
> to the description to say a similar arguement applies to the event_handler()
> 
> Reply to your comment inline. I didn't understand this one.
> > 
> > > ---
> > >  drivers/staging/iio/adc/ad7280a.c | 46 ++++++++++++++++++++++++-------
> > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > > index 1f7ea5fb1e20..158a792c0bf8 100644
> > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > @@ -95,6 +95,23 @@
> > >  #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
> > >  #define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
> > >  
> > > +/* Transfer fields */
> > > +#define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> > > +#define AD7280A_TRANS_WRITE_ADDR_MSK		GENMASK(26, 21)
> > > +#define AD7280A_TRANS_WRITE_VAL_MSK		GENMASK(20, 13)
> > > +#define AD7280A_TRANS_WRITE_ALL_MSK		BIT(12)
> > > +#define AD7280A_TRANS_WRITE_CRC_MSK		GENMASK(10, 3)
> > > +#define AD7280A_TRANS_WRITE_RES_PATTERN		0x2
> > > +
> > > +/* Layouts differ for channel vs other registers */
> > > +#define AD7280A_TRANS_READ_DEVADDR_MSK		GENMASK(31, 27)
> > > +#define AD7280A_TRANS_READ_CONV_CHANADDR_MSK	GENMASK(26, 23)
> > > +#define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
> > > +#define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
> > > +#define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> > > +#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> > > +#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
> > > +
> > >  /* Magic value used to indicate this special case */
> > >  #define AD7280A_ALL_CELLS				(0xAD << 16)
> > >  
> > > @@ -216,10 +233,16 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
> > >  static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
> > >  			unsigned int addr, bool all, unsigned int val)
> > >  {
> > > -	unsigned int reg = devaddr << 27 | addr << 21 |
> > > -			(val & 0xFF) << 13 | all << 12;
> > > +	unsigned int reg = FIELD_PREP(AD7280A_TRANS_WRITE_DEVADDR_MSK, devaddr) |
> > > +		FIELD_PREP(AD7280A_TRANS_WRITE_ADDR_MSK, addr) |
> > > +		FIELD_PREP(AD7280A_TRANS_WRITE_VAL_MSK, val) |
> > > +		FIELD_PREP(AD7280A_TRANS_WRITE_ALL_MSK, all);  
> > Does reg get initialized to 0? If not, we should take care of the reserved bit D11
> > 
> You have lost me here.  We are writing the whole register and this first
> assignment of reg uses = not |= so any bits not set explicitly will be zero.
> We could do a FIELD_PREP(BIT(11), 0) with an appropriate name for the BIT(11) define
> but that would be a bit odd.
> 
Oh yeah, I was just so paranoid about setting bit D11 to the point of forgetting
all reg bits would be initialized to zero, even without the direct assignment.
Setting bit D11 explicitly was a silly idea, forget about it.

> > > +
> > > +	reg |= FIELD_PREP(AD7280A_TRANS_WRITE_CRC_MSK,
> > > +			ad7280_calc_crc8(st->crc_tab, reg >> 11));
> > > +	/* Reserved b010 pattern not included crc calc */
> > > +	reg |= AD7280A_TRANS_WRITE_RES_PATTERN;
> > >  
> > > -	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
> > >  	st->tx = cpu_to_be32(reg);
> > >  
> > >  	return spi_write(st->spi, &st->tx, sizeof(st->tx));
