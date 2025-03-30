Return-Path: <linux-iio+bounces-17372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C944A75B73
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842153A9AF4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669561DAC81;
	Sun, 30 Mar 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD6Wg3Cr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233111C84CE;
	Sun, 30 Mar 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356224; cv=none; b=GkR79ztSBk7v9fkSa5PcjzNMZwbzOzGpba6yTbFxiZrWTmItiRJeCBvyo8Nv8AjnXf9oMDsbdqRAPIbRqvIPSYLTJ9D/WDpLiOq/0aU5DSS+eEd5ZlLS2eW7dHynbpdIoqqlK2wf+TMTRioEioLEo2F4txTtQ8mZYCryW0gGLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356224; c=relaxed/simple;
	bh=Z5iQ6l4T7EHuMNLeeQlrjmUTMQ9QLlcLdD59kVsa2cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgpLMcEd+LlyTX7xV5XdY6xK0aYOeO8b/wvVKHpwKHVzACPbbqmVbJxazyOJ4BSMnfxa/3xnG2L0Eh8xo5kRyMrmxHLWfNsnqCC85Z1TdrExZAKcjUzV3F7fcq/wadCtRuWJEjSAi8kXr9l5zgyi+Jckfo8LglHVwPff1LzT4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD6Wg3Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2551C4CEDD;
	Sun, 30 Mar 2025 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743356223;
	bh=Z5iQ6l4T7EHuMNLeeQlrjmUTMQ9QLlcLdD59kVsa2cM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PD6Wg3CrjHbt2AKlEzF/MoYg0vG95x1DukeNNFie7yep3rXgfhj7Y8Y2JG2J05G6e
	 pcR5pwo3fmZTbDomPIP9IPmqjN7jCGU+svejBGGVOul0MIlPrvyKZDCjQoaaFRZrGa
	 xBvpvvwgAf9rAPh+B7JH911o8DJnLrcp6gKUf5D++ZBbxXUohRra8PHMWMExY8WL7R
	 R/EKMh8IHOMWqgVHnTLFEbHqTIOhJXgQ/gnLMy83U3Jf4zONo1eT8BZ0CcR3gOURD7
	 x4TtgJKDXkNSzpfX4p8I8A5oW3qw2lNgrfsySSsUN01emplYXJxK9OJe9F4dEx6+X2
	 GUAdNUA5rIBCw==
Date: Sun, 30 Mar 2025 18:36:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] iio: light: al3010: Improve al3010_init error
 handling with dev_err_probe
Message-ID: <20250330183655.58bd22e8@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-10-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-10-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:49 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Slight simplification of the code.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
This one is fine but given I've not picked up 9 I can't pick this up either
for this version.

Thanks,

Jonathan

> ---
>  drivers/iio/light/al3010.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 8098c92c9572befe92d00ef0785ded5e1a08d587..af7ed028259837f2232f30072b87cc0da7c77f37 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -184,10 +184,8 @@ static int al3010_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = al3010_init(data);
> -	if (ret < 0) {
> -		dev_err(dev, "al3010 chip init failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init ALS\n");
>  
>  	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
>  	if (ret)
> 


