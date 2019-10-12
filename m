Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE75D4F6B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJLLuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJLLse (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:48:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7160C2087E;
        Sat, 12 Oct 2019 11:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880914;
        bh=mixF/9DhPwuaWwU/UcQjgJK8wA0edZE2ZQjv8qZYsBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GhVFHOW6+fqR2aZCka42+UXhOizlcgKJzUv6vncHt1TrLcsNeT73Y4baR5eQ3tZ4V
         6Kd16icJsn+anshXpec1VmDs8x5TQV+rFCD3FU2+0DgSHNExVMhgv3sgYjkPolTGT2
         4+XwWk3WI4h4arQxRXnuBmTmf75rbw2tzQZqCuGE=
Date:   Sat, 12 Oct 2019 12:48:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: adis16400: fix compiler warnings
Message-ID: <20191012124830.49a0e3c7@archlinux>
In-Reply-To: <20191008085156.6255-1-alexandru.ardelean@analog.com>
References: <20191008085156.6255-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Oct 2019 11:51:56 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> GCC 8 complains about plenty of 'maybe-uninitialized' warnings.
> This patch fixes all of them.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied in a bit of a hurry as Greg ran into these as well.

Pull request already gone out.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index e042a2aabf6b..d0b7dce798f4 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -325,7 +325,7 @@ static struct adis_burst adis16400_burst = {
>  static int adis16334_get_freq(struct adis16400_state *st)
>  {
>  	int ret;
> -	uint16_t t;
> +	uint16_t t = 0;
>  
>  	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
>  	if (ret < 0)
> @@ -338,7 +338,7 @@ static int adis16334_get_freq(struct adis16400_state *st)
>  
>  static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
>  {
> -	unsigned int t;
> +	unsigned int t = 0;
>  
>  	if (freq < 819200)
>  		t = ilog2(819200 / freq);
> @@ -357,7 +357,7 @@ static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
>  static int adis16400_get_freq(struct adis16400_state *st)
>  {
>  	int sps, ret;
> -	uint16_t t;
> +	uint16_t t = 0;
>  
>  	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
>  	if (ret < 0)
> @@ -408,7 +408,7 @@ static const unsigned int adis16400_3db_divisors[] = {
>  static int __adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
>  {
>  	struct adis16400_state *st = iio_priv(indio_dev);
> -	uint16_t val16;
> +	uint16_t val16 = 0;
>  	int i, ret;
>  
>  	for (i = ARRAY_SIZE(adis16400_3db_divisors) - 1; i >= 1; i--) {
> @@ -554,7 +554,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct adis16400_state *st = iio_priv(indio_dev);
>  	struct mutex *slock = &st->adis.state_lock;
> -	int16_t val16;
> +	int16_t val16 = 0;
>  	int ret;
>  
>  	switch (info) {

