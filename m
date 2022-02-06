Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B54AB0D0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 18:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbiBFRI3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 12:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiBFRI2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 12:08:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D7C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 09:08:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CBF0ACE0DAF
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 17:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59292C340E9;
        Sun,  6 Feb 2022 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644167303;
        bh=TqUaTuYOflRny4q6BmPxwu9FCBeAj3XpF59bC+fovy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NXk9i3wrXmUsPjyh4abpNuVSDJHQNC/SvlEwa6t2kjb/8ecRwQvZ0zgDbV8DFbvcr
         PX4O6u4M5LvVcm1eWV2Ygi5HyqPZIXxJ8+vNz5xaz2el39dhU2Xfm7N7xGBrAgXA+r
         o6FdCU9Za3csmvbcNprYDLILK3RqdWO23705i/hriqk7EqZGNXga//MsmuWVACYhlq
         mUDhP+mHiZoN6/STFJHNRymHW16btjMacdR+n0Bj5I5ID0uyGYjI6diK71/DDjjZ3W
         737Td85vzFHpMw2OWMMmFHLA6mOFEFn4JNGD8/AQZWCETKHCpCnj2qhFYfJJtxOwEw
         HUSLubAMZ3XzA==
Date:   Sun, 6 Feb 2022 17:14:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/17] staging:iio:adc:ad7280a: Use bitfield ops to
 managed fields in transfers.
Message-ID: <20220206171454.7be8dd34@jic23-huawei>
In-Reply-To: <YbjQeDekwU1wTdrF@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-6-jic23@kernel.org>
        <YbjQeDekwU1wTdrF@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Dec 2021 14:12:24 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Minor bit inline.
> 
> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The write and two types of read transfer are sufficiently complex that
> > they benefit from the clarity of using FIELD_PREP() and FIELD_GET()
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Those hunks you highlighted in patch 2 now in this patch and I've added a note
to the description to say a similar arguement applies to the event_handler()

Reply to your comment inline. I didn't understand this one.
> 
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 46 ++++++++++++++++++++++++-------
> >  1 file changed, 36 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 1f7ea5fb1e20..158a792c0bf8 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -95,6 +95,23 @@
> >  #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
> >  #define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
> >  
> > +/* Transfer fields */
> > +#define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> > +#define AD7280A_TRANS_WRITE_ADDR_MSK		GENMASK(26, 21)
> > +#define AD7280A_TRANS_WRITE_VAL_MSK		GENMASK(20, 13)
> > +#define AD7280A_TRANS_WRITE_ALL_MSK		BIT(12)
> > +#define AD7280A_TRANS_WRITE_CRC_MSK		GENMASK(10, 3)
> > +#define AD7280A_TRANS_WRITE_RES_PATTERN		0x2
> > +
> > +/* Layouts differ for channel vs other registers */
> > +#define AD7280A_TRANS_READ_DEVADDR_MSK		GENMASK(31, 27)
> > +#define AD7280A_TRANS_READ_CONV_CHANADDR_MSK	GENMASK(26, 23)
> > +#define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
> > +#define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
> > +#define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> > +#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> > +#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
> > +
> >  /* Magic value used to indicate this special case */
> >  #define AD7280A_ALL_CELLS				(0xAD << 16)
> >  
> > @@ -216,10 +233,16 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
> >  static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
> >  			unsigned int addr, bool all, unsigned int val)
> >  {
> > -	unsigned int reg = devaddr << 27 | addr << 21 |
> > -			(val & 0xFF) << 13 | all << 12;
> > +	unsigned int reg = FIELD_PREP(AD7280A_TRANS_WRITE_DEVADDR_MSK, devaddr) |
> > +		FIELD_PREP(AD7280A_TRANS_WRITE_ADDR_MSK, addr) |
> > +		FIELD_PREP(AD7280A_TRANS_WRITE_VAL_MSK, val) |
> > +		FIELD_PREP(AD7280A_TRANS_WRITE_ALL_MSK, all);  
> Does reg get initialized to 0? If not, we should take care of the reserved bit D11
> 
You have lost me here.  We are writing the whole register and this first
assignment of reg uses = not |= so any bits not set explicitly will be zero.
We could do a FIELD_PREP(BIT(11), 0) with an appropriate name for the BIT(11) define
but that would be a bit odd.

> > +
> > +	reg |= FIELD_PREP(AD7280A_TRANS_WRITE_CRC_MSK,
> > +			ad7280_calc_crc8(st->crc_tab, reg >> 11));
> > +	/* Reserved b010 pattern not included crc calc */
> > +	reg |= AD7280A_TRANS_WRITE_RES_PATTERN;
> >  
> > -	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
> >  	st->tx = cpu_to_be32(reg);
> >  
> >  	return spi_write(st->spi, &st->tx, sizeof(st->tx));
