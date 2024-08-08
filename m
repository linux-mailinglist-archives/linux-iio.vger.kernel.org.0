Return-Path: <linux-iio+bounces-8321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78194B783
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 09:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB71F25414
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 07:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D1188CC6;
	Thu,  8 Aug 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm4BbRdf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047A188CBA
	for <linux-iio@vger.kernel.org>; Thu,  8 Aug 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101142; cv=none; b=XTW1lfYEuzOksPjQf472U/a5TRhfYLz4c8diu1b3IEvw0xHAnzTXSlWfkPH3fNEUZ95TtFjh8kd5/2s5uPO2sqsG5hZx7AzM0Zl1vqc/zSwOVcLTixP84TRYC2+l3F+VfZzAwoem/8x4kdBGLd1IokOxLD6BwcqQ6Hu80ZnQQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101142; c=relaxed/simple;
	bh=gfM5rAUrnho/6p4J58/X0FMzKX3WMYAisoEIqOA/zVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SG/OraztxVyWzRGY59/7VyDWNhdwhXGs76FTj7bkHJCfJ2cMQAiD47hcHa8dUkYy3/Ilu5KizkJyBNv4eLDLIw00CDAIYnGQ3ZOsq6eTGBosatDWqfdDWiLnzS+/PRQ8DCVWShyfmOF4UFcqo4qkXPUQphnpss1whFVaiRdctXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hm4BbRdf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a83a968ddso73139266b.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Aug 2024 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723101139; x=1723705939; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYZ8nlG9WtMNb/aTcVrIx12Eceonf872JvawFCrScOM=;
        b=hm4BbRdf38i+LYPCNDKqPEkWzL7Tk9+x6DvzMpik7FiFHIvc2xJibkfXfA8Fjf4VCJ
         VZMDzU9ZXGFC448KLvhpwnukuJ9MgWUIKGYSMRRF1PcaofmyrWPfBbdA+cGTDezxEEaL
         kth6NrCJsoRiTn0sldg85IAGDzRFHLBP65zPjupQU3LQ5sAfE6252A9hSzeqcV0UjUVu
         /z4vDOm3wkqKrc+GxP3torrBG1Drw0x2pjUud61eGu+tS+YSyy9zoAcUT2KmrgjCDmho
         tUFwJ8MCzrttp4gxiqUEi9Jg0l0s3cng6VCw4NCnTnWDxs5tQqv68wYPMx06BdoELLNf
         RMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723101139; x=1723705939;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYZ8nlG9WtMNb/aTcVrIx12Eceonf872JvawFCrScOM=;
        b=krfhO4Mj7kDX/PdnLLBK92ZDtvEFwUgCLIQ5zHE4S3MUDq0BLrwz4j7toswiXBdo9J
         wHraIkdnuRH6chW6pjQJanEPrvF7TpmiTq4QvIt9luOCl5C0GvNE1x2OzurRzkSw4Iz1
         GLmWjk3V0VtldJrbCfPU8V5nS0bRbIBOh7E6P6uw7dsUNJOjIxEAXUENxoBdlWbPUIlJ
         rhR3WToqqq48aRL2SQCrj+7Rhv0zESruJDLx6L5UvR9LVhkIH3cuOm7wnOVa0ipah2eU
         wbQ2pbNCo+mRNZN6CPCHdFJBPoD85CFh33P07tq/uUKGUmHc6qFXRr6wz/8sZgx08w1V
         efig==
X-Gm-Message-State: AOJu0YxQg3gr4qF+xH2BEqxrn7Gd9q4jbqKosSkB0zH9oNhvo1BU3XgQ
	urdWtM+l1DROG6/0Ty/LoW1H1bVTRM3NZKteBRX7EIW15u3UahL/rbJyU82TmvJjkPOqQvHIG/e
	+
X-Google-Smtp-Source: AGHT+IHKgoCKQ5lf92pxFhhsIYbkxpd332q43dZKVhOO7y1K39/pDa6tZVcBNJbaIXWewyJos3Gcgg==
X-Received: by 2002:a17:907:9482:b0:a7a:9ece:ea68 with SMTP id a640c23a62f3a-a8090c32f4cmr58315066b.10.1723101138321;
        Thu, 08 Aug 2024 00:12:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437c6sm708089166b.129.2024.08.08.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 00:12:17 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:12:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: light: noa1305: Make integration time configurable
Message-ID: <fb9734ff-5029-4855-971a-3dc734881b4e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Marek Vasut,

Commit 025f23cfebad ("iio: light: noa1305: Make integration time
configurable") from Jul 15, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/light/noa1305.c:201 noa1305_write_raw()
	error: buffer overflow 'noa1305_int_time_available' 16 <= 31

drivers/iio/light/noa1305.c
    183 static int noa1305_write_raw(struct iio_dev *indio_dev,
    184                              struct iio_chan_spec const *chan,
    185                              int val, int val2, long mask)
    186 {
    187         struct noa1305_priv *priv = iio_priv(indio_dev);
    188         int i;
    189 
    190         if (chan->type != IIO_LIGHT)
    191                 return -EINVAL;
    192 
    193         if (mask != IIO_CHAN_INFO_INT_TIME)
    194                 return -EINVAL;
    195 
    196         if (val)        /* >= 1s integration time not supported */
    197                 return -EINVAL;
    198 
    199         /* Look up integration time register settings and write it if found. */
    200         for (i = 0; i < ARRAY_SIZE(noa1305_int_time_available); i++)
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^

--> 201                 if (noa1305_int_time_available[2 * i + 1] == val2)
                                                       ^^^^^^^^^
Buffer overflow

    202                         return regmap_write(priv->regmap, NOA1305_REG_INTEGRATION_TIME, i);
    203 
    204         return -EINVAL;
    205 }

regards,
dan carpenter

