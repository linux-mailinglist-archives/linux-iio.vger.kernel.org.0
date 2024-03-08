Return-Path: <linux-iio+bounces-3395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84D876AF1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 19:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902771C215EC
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AC33CC4;
	Fri,  8 Mar 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="CjYqNiUO"
X-Original-To: linux-iio@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E282C6B2
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924115; cv=none; b=oiC3Z2UHZ7hxDN36tCVBi9FVQmvDFujvrh8uri14cXiMnzS3pz73aOPq5auYbS+8BXBPQ87X8HLFJFe9vSJP8je+286la5zQlrsajBtodtcPH/6tARV892V4ZXJ+N2+8kwh1S6T8dt1VMcJ6yOonAWq7hAI/fkwNthgq15F33uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924115; c=relaxed/simple;
	bh=6eYSfzhw0N019P4sNgBxB+nsfL62N8jIfJFDySaisJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaxIAYJWvqbpTXqPacV57FbofjvhhtP4Vg/j/JL7H/HVZEoozz6nSkKbJyKC0DYE1hqNYt9NPymAaDpTPeZetjTU/bTMp9qwqJrh5tLS30x9JVh5GrCNTCojN82zf0zXmWUjs8y7XlN3e3J+9eSfe8T/puk80LfmdWUcMe88iZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=CjYqNiUO; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PcN3Nx2mfuqKB03NWrNNv3VUwmlQQyQtQA4izBo6xrM=; b=CjYqNiUOsxeP/ciqhCJoh4C9vN
	zZfKCa7tr0M8fhua2djA9tLZ1hQtoWQYaGQSQ63qGIPJWCSuFJhadvZgFnv+c6UV006xxCr6CLzdQ
	ac6L4qbppmQ/frzRpMVPO7CbZ6uWBELxodzaIwp5vZk1olB95u7kzaBjpbGfcJveGJ3T54HPKRW1d
	48Ugd79H8CZPXsluGZXZYZPnsXMRE16wAM3GqOPtk4ApefCotryDb4+//ZNzWkHgcA4w0/Rr1VaRF
	v4ZyWS8qTt2uY1l9InQHB9IkhJhQ69qdD6fxVCws8uI40U6sErWcEUkKiMZwLcPUBCUBfJ2YDrKMx
	ZjTuHUIQ==;
Received: from [167.98.27.226] (helo=[10.35.6.244])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rifN8-00CPLu-EM; Fri, 08 Mar 2024 18:55:10 +0000
Message-ID: <e0bee548-9a62-469a-8c2c-9548626616d6@codethink.co.uk>
Date: Fri, 8 Mar 2024 18:55:09 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad5755: fix unised of_match table
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, Michael.Hennerich@analog.com
References: <20240308181411.1916460-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20240308181411.1916460-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 08/03/2024 18:14, Ben Dooks wrote:
> If the ad5755 is not being built as a module, then we get an unused warning
> about the ad5755_of_match[] array as this is only used by the macro
> MODULE_DEVICE_TABLE. Fix this by adding an #ifdef MODULE around it to
> silence:
> 
> drivers/iio/dac/ad5755.c:866:34: warning: ‘ad5755_of_match’ defined but not used [-Wunused-const-variable=]
>    866 | static const struct of_device_id ad5755_of_match[] = {
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/iio/dac/ad5755.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 404865e35460..fb99c8472788 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -863,6 +863,7 @@ static const struct spi_device_id ad5755_id[] = {
>   };
>   MODULE_DEVICE_TABLE(spi, ad5755_id);
>   
> +#ifndef MODULE

Just noticed the use of ifnded instead of ifdef here. Will fix Monday.

>   static const struct of_device_id ad5755_of_match[] = {
>   	{ .compatible = "adi,ad5755" },
>   	{ .compatible = "adi,ad5755-1" },
> @@ -872,6 +873,7 @@ static const struct of_device_id ad5755_of_match[] = {
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ad5755_of_match);
> +#endif
>   
>   static struct spi_driver ad5755_driver = {
>   	.driver = {

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


