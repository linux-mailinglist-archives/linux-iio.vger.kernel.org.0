Return-Path: <linux-iio+bounces-25034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B992BD4E6A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6148C18A6786
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581892949E0;
	Mon, 13 Oct 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="neASAnre"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EA3090D0
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371621; cv=none; b=jpjpJsfsKN7Fw3ACkZ+UHRHGO+npYPwBZHpVMV4QdLJktQ91o6H1501l706Gs1CXFQ/d7IbBjpTEoyLUWcTUx7Z7yUwU6PeESosK1rnkfmYdvDQIo2DYkZaMlFKzhrhY++tWjPY8Oqw90jWQD2+O1sdc1craU5v0412GW10NGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371621; c=relaxed/simple;
	bh=lWg9ZBhqyOPthQ75n8I93YLiXjllq4HChSc1fq/PwWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJty/kamDnBy90lrdrje6wWqRmhZgyAIZLNSnoI9R5LKr/hy1mgawg/z5lDeIMNNERi97OJLLwNsLPbF1CHwj4ygofw2WwH0hhKR07rsJWrs1O90M0qwx4Qt01NRKeeu1TvgAme+PXqAE/LpQDIA+ksklUT1azCS1S6kiGBolJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=neASAnre; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 1DC13104CBCA
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 21:36:52 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 1DC13104CBCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760371612; bh=lWg9ZBhqyOPthQ75n8I93YLiXjllq4HChSc1fq/PwWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neASAnreaEY9vsTtKzfd4YABFgykxjxC1NNz6fjwZ9dEcc5NcQpFpDaDAtlJ50jKR
	 psUvCzzctvZvzx7cEgO7gO+riLEIYQBl0qj+FPcSyT0BMNoNYK4krIHgBYcNg8lJoX
	 UHD+IHfhPLx6Ny6Zpf2G89Kybd+CBK1tTAM1Bfhc=
Received: (qmail 30567 invoked by uid 510); 13 Oct 2025 21:36:52 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.533514 secs; 13 Oct 2025 21:36:52 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 13 Oct 2025 21:36:48 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id AA1B6341504;
	Mon, 13 Oct 2025 21:36:47 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 6BCD71E8155F;
	Mon, 13 Oct 2025 21:36:47 +0530 (IST)
Date: Mon, 13 Oct 2025 21:36:42 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <20251013-16642-1563944@bhairav-test.ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <20251012203658.167f3362@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012203658.167f3362@jic23-huawei>

On Sun, Oct 12, 2025 at 08:36:58PM +0100, Jonathan Cameron wrote:
> On Sat, 11 Oct 2025 17:55:28 +0530
> Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> 
> Hi Akhilesh, 
> 
> Thanks for sending this and a late welcome to IIO.

Hi Jonathan, Thanks for the review.
Addressing the comments and suggestions in v2.

> 
> > Add driver for Aosong adp810 differential pressure and
> > temperature sensor. This sensor provides I2C interface for
> > reading data. Calculate CRC of the data received using standard
> > crc8 library to verify data integrity.
> > 
> Wrap commit messages to 75 chars.

I think it is already wrapped to 75. 
Still, I will recheck and fix if required.

> 
> > Tested on TI am62x sk board with sensor connected at i2c-2
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> 
> Where I've remembered Andy commenting on something I've not duplicated
> (assuming I even noticed the same thing!)
> 
> A few things may contradict or provide alternative suggestions though!
> 
> Jonathan

Okay.

> 
> 
> > diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> > new file mode 100644
> > index 000000000000..ff73330b34fc
> > --- /dev/null
> > +++ b/drivers/iio/pressure/adp810.c
> > @@ -0,0 +1,205 @@
> > +/* Trigger command to send to start measurement by the sensor */
> > +#define ADP810_TRIGGER_COMMAND		0x2d37
> > +#define ADP810_CRC8_POLYNOMIAL		0x31
> > +
> > +DECLARE_CRC8_TABLE(crc_table);
> > +
> > +struct adp810_read_buf {
> > +	u8 dp_msb;
> > +	u8 dp_lsb;
> 
> __be16 dp;
> or u8 dp[2]; 
> 
> > +	u8 dp_crc;
> > +	u8 tmp_msb;
> > +	u8 tmp_lsb;
> 
> __be16_tmp;
> 
> > +	u8 tmp_crc;
> > +	u8 sf_msb;
> > +	u8 sf_lsb;
> 
> __be16 sf;
> 
> > +	u8 sf_crc;
> > +} __packed;
> With packed (which you didn't need previously).
> (more below)

Yes. Used __be16 to indicate big endian.

> 
> > +
> > +struct adp810_data {
> > +	struct i2c_client *client;
> > +	/* Use lock to synchronize access to device during read sequence */
> > +	struct mutex lock;
> > +};
> > +
> > +static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	int ret;
> Not sure what ordering you are using for declarations but this looks a bit
> odd.  If nothing else makes more sense go with reverse xmas tree.

okay. I will use "reverse xmas tree" wherever applicable.

> > +	if (buf->tmp_crc != crc8(crc_table, &buf->tmp_msb, 0x2, CRC8_INIT_VALUE)) {
> > +		dev_err(&client->dev, "CRC error for temperature\n");
> > +		return -EIO;
> > +	}
> > +
> > +	if (buf->sf_crc != crc8(crc_table, &buf->sf_msb, 0x2, CRC8_INIT_VALUE)) {
> > +		dev_err(&client->dev, "CRC error for scale\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp810_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct adp810_data *data = iio_priv(indio_dev);
> > +	struct adp810_read_buf buf = {0};
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +	ret = adp810_measure(data, &buf);
> > +	mutex_unlock(&data->lock);
> > +
> > +	if (ret) {
> > +		dev_err(&indio_dev->dev, "Failed to read from device\n");
> It's normally more informative to use the parent dev for error messages.
> data->client->dev here.
> Probably add a local variable struct device *dev, to avoid making the dev_err() lines
> even longer.

Agree. Will use parent dev in all dev_err() calls.

> 
> > +		return ret;
> > +	}
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_PRESSURE:
> > +			*val = buf.dp_msb << 8 | buf.dp_lsb;
> 
> They are next to each other so either treating them as a small array or
> I think you can even make the be16 you can use
> 			*val = get_unaligned_be16(buf.dp);
> for all 3 similar cases.  1st and 3rd are actually aligned but
> lets not rely on that.

ACK. Used __be16 along with helpers get_unalinged_be16() to handle
endianess in clean and portable way.

> 
> > +			return IIO_VAL_INT;
> > +		case IIO_TEMP:
> > +			*val = buf.tmp_msb << 8 | buf.tmp_lsb;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_PRESSURE:
> > +			*val = buf.sf_msb << 8 | buf.sf_lsb;
> > +			return IIO_VAL_INT;
> > +		case IIO_TEMP:
> 
> > +static int adp810_probe(struct i2c_client *client)
> > +{
> > +	const struct i2c_device_id *dev_id = i2c_client_get_device_id(client);
> > +	struct device *dev = &client->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct adp810_data *data;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +	mutex_init(&data->lock);
> Andy mentioned this.  I used not to care about mutex debugging in IIO drivers
> as in most cases lifetimes of the containing structure are so closely aligned
> to the mutex it wasn't worth the extra debugging provided by mutex_destroy().
> 
> Now we can do
> 	ret = devm_mutex_init(&data->lock);
> 	if (ret)
> 		return ret;
> 
> It's so easy I would like to see it used in all new code even when the
> gain is very small.

Okay. Using resource managed mutex_init : devm_mutex_init()

> 
> > +
> > +	indio_dev->name = dev_id->name;
> 
> Just set it to "adp810" here.  We can add more complex handling when the driver
> supports additional parts.  The advantage of an explicit string for now is
> we don't have to think about what it can be.
> 

Sure. Directly using string : indio_dev->name = "adp810";

> > +	indio_dev->channels = adp810_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adp810_channels);
> > +	indio_dev->info = &adp810_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
> > +
> > +	return ret;
> return 0; 
> 
> As that clearly indicates to the reader that you can't get here in an error case.

Yes. Fixed.

Regards,
Akhilesh



