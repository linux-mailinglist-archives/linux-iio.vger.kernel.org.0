Return-Path: <linux-iio+bounces-4399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A948ABC1C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D507B1F2129D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87142628B;
	Sat, 20 Apr 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ik+35J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCA1EA7D;
	Sat, 20 Apr 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713625220; cv=none; b=ZJzLLuSC0JsZdXc+ZWmaAKk4ZCU5eDES0XoXToFHK7PGBnhS/gVcVSEDvrVXy96DF3R664vP7G/waeCXg4RQoQofGOelsP6ZU2K950cHpiU1Ebs05ZNByOfmfl84Dh9Mr0vQefEYVdSoAd+oTGhXP9MMiOwJtMHv6CE1RL3j5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713625220; c=relaxed/simple;
	bh=ftupAihT0EorcprLdFe49OCcdoL7GVPGYRep8pVwN8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Df19hgXMil+DbeDxmMHZ+D3aMVPasNGvziM5YJ3aPTJqw6l3eyAVeYsMRlJKGUdTQsn1UGPa6SierUa3+nLfb6Vx/gWvTqdLdQ6ZTWzfMuavh8fk46tYs6TjSLlvlK3bGbWQqB782V83sDM2iO6IVv/H5phC22VUCVyDy4exQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ik+35J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B20C072AA;
	Sat, 20 Apr 2024 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713625220;
	bh=ftupAihT0EorcprLdFe49OCcdoL7GVPGYRep8pVwN8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r7ik+35JP3hPgXaQOc/J0WkGRzl5MWOZkug7oU4DsiHOF9L5owODQYlnWtTisplKk
	 T+PPEI5lmcds95yvO/mgRUGZUinlfKSsHArB0tE/UfM9K+pHKxSLHfTPYdc+zrFr4D
	 dWHffjNMUyXnBxk7OuTfiS+elAjUYSl2BznLP34xsxiNjadaRC1Eu2p1u+3G68qGI6
	 OcCnzQBdBLywwn7e+/e0KjTMARBrbNQ4J0AZ/qsW7hR/xlSZVbcaEOqDNvaImwWiAC
	 ZW+zzNC9ZpJ9cMIDBq1PUVoHvYx0ZxUXmz5K3P5pMjdboMwAQNcZJm5Ui5ojdi2B99
	 8ZOpfAh5GZpRg==
Date: Sat, 20 Apr 2024 16:00:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/8] iio: backend: add API for interface tuning
Message-ID: <20240420160006.720a3810@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-1-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:44 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> This is in preparation for supporting interface tuning in one for the
> devices using the axi-adc backend. The new added interfaces are all
> needed for that calibration:

Would be good to have a little more info in this commit message on what
interface tuning involves?  I hope a tuning fork and a very good sense
of hearing...

> 
>  * iio_backend_test_pattern_set();
>  * iio_backend_chan_status();
>  * iio_backend_iodelay_set();
>  * iio_backend_data_sample_trigger().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Otherwise, trivial stuff inline.  Mostly looks fine. 

I appreciate you pointed out the taps thing was unit free and hence
possibly controversial.  Not much we can do about it and reality is
its a tweak factor - things like calibbias are unit free as well
for exactly the reason that they tend to be incredibly hardware dependent
and sometimes even instance of hardware dependent.

Jonathan

> ---
>  drivers/iio/industrialio-backend.c | 86 ++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        | 57 +++++++++++++++++++++----
>  2 files changed, 136 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 2fea2bbbe47fd..45eea3b725a35 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -186,6 +186,92 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_data_format_set, IIO_BACKEND);
>  
> +/**
> + * iio_backend_test_pattern_set - Configure a test pattern
> + * @back:	Backend device
> + * @chan:	Channel number
> + * @pattern:
> + *
> + * Configure a test pattern on the backend. This is typically used for
> + * calibrating the timings on the data digital interface.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_test_pattern_set(struct iio_backend *back,
> +				 unsigned int chan,
> +				 enum iio_backend_test_pattern pattern)
> +{
> +	if (pattern >= IIO_BACKEND_TEST_PATTERN_MAX)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, test_pattern_set, chan, pattern);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, IIO_BACKEND);
> +
> +/**
> + * iio_backend_chan_status - Get the channel status
> + * @back:	Backend device
> + * @chan:	Channel number
> + * @status:	Channel status

Feels premature to define a structure for status when it simply returns if
there is an error so far.  Maybe simplify for now, and revisit once that
structure needs to be more complex?

> + *
> + * Get the current state of the backend channel. Typically used to check if
> + * there were any errors sending/receiving data.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
> +			    struct iio_backend_chan_status *status)
> +{
> +	return iio_backend_op_call(back, chan_status, chan, status);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_chan_status, IIO_BACKEND);
> +
> +/**
> + * iio_backend_iodelay_set - Set digital I/O delay
> + * @back:	Backend device
> + * @lane:	Lane number
> + * @tap:	Number of taps
> + *
> + * Controls delays on sending/receiving data. One usecase for this is to
> + * calibrate the data digital interface so we get the best results when
> + * transferring data. Note that @tap has no unit since the actual delay per tap
> + * is very backend specific. Hence, frontend devices typically should go through
> + * an array of @taps (the size of that array should typically match the size of
> + * calibration points on the frontend device) and call this API.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
> +			    unsigned int tap)

taps maybe given it's a number of them?
Is this an industry standard term - sounds like it probably is but my
google fu is failing.

> +{
> +	return iio_backend_op_call(back, iodelay_set, lane, tap);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_iodelay_set, IIO_BACKEND);
> +
> +/**
> + * iio_backend_data_sample_trigger - Control when to sample data
> + * @back:	Backend device
> + * @trigger:	Data trigger
> + *
> + * Mostly useful for input backends. Configures the backend for when to sample
> + * data (eg: rising vs falling edge).

Feels like it might become a flags field at some point, but enum is fine for
trigger for now I guess.

> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_sample_trigger(struct iio_backend *back,
> +				    enum iio_backend_sample_trigger trigger)
> +{
> +	if (trigger >= IIO_BACKEND_SAMPLE_TRIGGER_MAX)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, data_sample_trigger, trigger);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_sample_trigger, IIO_BACKEND);
> +
>  static void iio_backend_free_buffer(void *arg)
>  {
>  	struct iio_backend_buffer_pair *pair = arg;
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index a6d79381866ec..ad793fe0d78c2 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -15,6 +15,19 @@ enum iio_backend_data_type {
>  	IIO_BACKEND_DATA_TYPE_MAX
>  };
>  
> +/* vendor specific from 32 */
> +enum iio_backend_test_pattern {
> +	/* modified prbs9 */
> +	IIO_BACKEND_ADI_PRBS_9A = 32,

Not knowing anything much about this, does it make sense to use an enum,
or should we face facts that we can't have a true generic interface
and just use a suitably sized int?

How do you unset the test pattern? I expected a IIO_BACKEND_NO_TESTPATERN = 0
or something like that.

> +	IIO_BACKEND_TEST_PATTERN_MAX
> +};
> +
> +enum iio_backend_sample_trigger {
> +	IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING,
> +	IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING,
> +	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> +};
> +
>  /**
>   * struct iio_backend_data_fmt - Backend data format
>   * @type:		Data type.
> @@ -28,15 +41,27 @@ struct iio_backend_data_fmt {
>  	bool enable;
>  };
>  
> +/**
> + * struct iio_backend_chan_status - Backend channel status
> + *  @errors:	Errors occurred when sending/receiving data.

error, it's only a bool so we know there was at least one.

> + */
> +struct iio_backend_chan_status {
> +	bool errors;
> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
> - * @enable:		Enable backend.
> - * @disable:		Disable backend.
> - * @chan_enable:	Enable one channel.
> - * @chan_disable:	Disable one channel.
> - * @data_format_set:	Configure the data format for a specific channel.
> - * @request_buffer:	Request an IIO buffer.
> - * @free_buffer:	Free an IIO buffer.
> + * @enable:			Enable backend.

Hmm. I dislike aligning comments because of this sort of noise.
I guess I can cope without the ideal precursor patch making the padding
change, but I am moaning about it...

> + * @disable:			Disable backend.
> + * @chan_enable:		Enable one channel.
> + * @chan_disable:		Disable one channel.
> + * @data_format_set:		Configure the data format for a specific channel.
> + * @test_pattern_set:		Configure a test pattern.
> + * @chan_status:		Get the channel status.
> + * @iodelay_set:		Set digital I/O delay.
> + * @data_sample_trigger:	Control when to sample data.
> + * @request_buffer:		Request an IIO buffer.
> + * @free_buffer:		Free an IIO buffer.
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -45,6 +70,15 @@ struct iio_backend_ops {
>  	int (*chan_disable)(struct iio_backend *back, unsigned int chan);
>  	int (*data_format_set)(struct iio_backend *back, unsigned int chan,
>  			       const struct iio_backend_data_fmt *data);
> +	int (*test_pattern_set)(struct iio_backend *back,
> +				unsigned int chan,
> +				enum iio_backend_test_pattern pattern);
> +	int (*chan_status)(struct iio_backend *back, unsigned int chan,
> +			   struct iio_backend_chan_status *status);
> +	int (*iodelay_set)(struct iio_backend *back, unsigned int chan,
> +			   unsigned int tap);
> +	int (*data_sample_trigger)(struct iio_backend *back,
> +				   enum iio_backend_sample_trigger trigger);
>  	struct iio_buffer *(*request_buffer)(struct iio_backend *back,
>  					     staptruct iio_dev *indio_dev);
>  	void (*free_buffer)(struct iio_backend *back,
> @@ -56,6 +90,15 @@ int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
>  int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
>  int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
>  				const struct iio_backend_data_fmt *data);
> +int iio_backend_test_pattern_set(struct iio_backend *back,
> +				 unsigned int chan,
> +				 enum iio_backend_test_pattern pattern);
> +int iio_backend_chan_status(struct iio_backend *back, unsigned int chan,
> +			    struct iio_backend_chan_status *status);
> +int iio_backend_iodelay_set(struct iio_backend *back, unsigned int lane,
> +			    unsigned int tap);
> +int iio_backend_data_sample_trigger(struct iio_backend *back,
> +				    enum iio_backend_sample_trigger trigger);
>  int devm_iio_backend_request_buffer(struct device *dev,
>  				    struct iio_backend *back,
>  				    struct iio_dev *indio_dev);
> 


