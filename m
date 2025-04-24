Return-Path: <linux-iio+bounces-18599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F2A9AE4D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 15:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F87AAA2B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A128137E;
	Thu, 24 Apr 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="KV3OK7IT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04949280A5A
	for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499790; cv=none; b=WE8YNkMBsZkDwRwRIAffOyxYNFU4QJbCYSIGLPihBpqWfGnA7rKQGE89h9qJMyKU+IzlQDiNqPZFgglasHZs7lIRILhBY9di3r3GFmUH6rxCuqS5dBdEaJ3fsNReF90HZfx4OuiGHEhJd1gusqH5IWauFP3dLJ0uMQadlmjZmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499790; c=relaxed/simple;
	bh=q1jrGK1quJncxuHJY3WK9oZdbDjpEBibDUyhRabnBmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDHY1bK3Der60FeL+la8dlupZIS5HZydA6kN3Q9/0Ap0B88F+frlKRjv1SLE7OgXrdwDOD9EaG7ymcA7TqMW6rQbT4wVFxXdKvo00+Nz0xac/HMkmnJK4jmFuqUEBmOiI8BNHN0GRDzXOJzvF/KCayA9lcbpCYk7BygJjqO2doQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=KV3OK7IT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso21814395ad.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1745499787; x=1746104587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Guf2pnnP/6jZRn0lKABiQpuBXBGyiAUeFNJtjlfmmyA=;
        b=KV3OK7ITbYiktbqPU/7W2KSufEWcF87FiApWjSSc3Biyxyy0fC25F+JsHkigIiBSIs
         fMSeQMd0gAgPoc+Z8KJJ7p6/Jngk/ZtMbrWA2B1ioy8Gh+efho1DZAjEAj2YFSgexcHD
         MQgvN3UYvNDU+Nsj9S7EHwnvn+F7j7NGNos0tSeBDcjoGekraXRv74XFo3YKJoKQ/dRY
         57Pa6GdW5HpKu2bppbIfz0BhWtgu7oFTjLoWQNhtbC8q9u2Diq9XNpt3kvDrU6TRKL9R
         7Hs5r8lFkzR3FJYYJoyaaGopr9tCbSI1wQX+PoqMk8H3xNSIbZjEHPivhwubwuX0w8jE
         MtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499787; x=1746104587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Guf2pnnP/6jZRn0lKABiQpuBXBGyiAUeFNJtjlfmmyA=;
        b=s1cGQNeAE1aZWUz4yNaQ8LYdWLPPKFDmzgSkTXf3rbtd88Tm2vgS3ZTzHWt0clFI60
         88r96ptZedrpzufDaaH/zXyAquIqAvYaZTEHMd20aLr+AMjUmoz+GFivMSQuKAqabOpm
         8ymvrHsjFiHaBQTR0vNJraNSfPKE4TfZPoq3RmLkX+GfsbFSPtpmuYqFAfpVeSXQ8Nno
         wKYhvKw7+xQ3He4Qs9hUUEo+FoWzhg1q8dqLk8SBAAgDH6SHwD/3NFA1XXL8R3AmShWi
         2dtG6cb1bc1RRTtBrOMQTqpyIF1x0zl83mRLyAuGiD1WjrRH+p+MBjt7dNmuPRt0MFZl
         v9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaaT3nU006pp8IzTVrubio/q42gU124og82kWlfRzpcvzcCrXw0AtmWrfH6FEbNZtIiLD367ew7dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0ekP+FgEOuEZeBTrTLXvRaI+mIjMF69Lg0Se0pxx6Z+oNHFu
	oKeXCOSybmTre1RFqhSgJmkoQjohX4YouJAj0z46oH8fGsk6OGj0SEsI9gPGuV9y79XTHzFOGvc
	L
X-Gm-Gg: ASbGnct652Y3eZzi7o7Y6Pf7CWYPHK2NS8Uh9eGSRXdSxLSjMT5hwdE1ziwc46FU129
	/rQJSUC6NvpB287fFZbaTx+NSYv0mfpfXTHx97nKOq2RH9yD+7GmSdvFEo2xLxLWvc8obR/14B1
	NjA/rm47HsBeW8VyiA6eL4gHYuE0ZBjRHVG4Au3ZjhxeDapeKTCJG3JXvZrIaeJWS19P1YkWUPg
	GTPOvv6cMOCu5rQGiIFSSYd+xHSeY/BOysPzItkJTiVIvhD+MF+u1mCRf7j6+BlP5G0jQjN1181
	XhPKIGb77krAFTVIwMxJP7tEiD0qljb6T0N3Z9wsiKVrXiDFr68jfzNqq3CXn7d/wE4qYJ91q45
	wIcM73nKgh8sbd35HjpqYnYIE+2Q2K4k9
X-Google-Smtp-Source: AGHT+IFyEGmY7zhTDN+jZo6spWH3dZqUsHPAADDl/IjwrtMxbUcWfTa1v6k060qCpeb+fafOZ9v2pw==
X-Received: by 2002:a17:902:cf01:b0:216:271d:e06c with SMTP id d9443c01a7336-22db47ae98amr32176465ad.4.1745499786974;
        Thu, 24 Apr 2025 06:03:06 -0700 (PDT)
Received: from [192.168.50.161] (61-245-156-102.3df59c.adl.nbn.aussiebb.net. [61.245.156.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216ba5sm12363655ad.222.2025.04.24.06.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:03:06 -0700 (PDT)
Message-ID: <222efff5-38d6-483f-8e5b-b0f07cb98130@tweaklogic.com>
Date: Thu, 24 Apr 2025 22:34:26 +0930
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
To: nattan <nattanferreira58@gmail.com>, jic23@kernel.org
Cc: lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
References: <20250422191114.32832-1-nattanferreira58@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20250422191114.32832-1-nattanferreira58@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nattan, Lucas,

> Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
> functions to use a helper function (apds9306_get_thresh_reg) for obtaining the
> correct register based on the direction of the event. This improves code
> readability,minimize the number of lines  and maintains consistency
It actually adds four more lines to the driver file. Rephrase maybe.

>   drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
20 additions and 16 deletions.
   
> @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
>   static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
>   				     int val)
>   {
> -	int var;
> +	int reg;
I like the name changed from 'var' to reg', makes much more sense.
>   	u8 buff[3];
>
There is always a balance/trade-off between modularity and execution speed.
I agree with Marcelo's reply in the first patch and I also think that separate function for this does not add much value.

Overall the patch looks good to me.

With the above:
Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Regards,
Subhajit Ghosh

