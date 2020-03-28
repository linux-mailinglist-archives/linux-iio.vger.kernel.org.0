Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32D61964E6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgC1Jzy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 05:55:54 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43394 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1Jzy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 05:55:54 -0400
Received: by mail-pf1-f181.google.com with SMTP id f206so5811332pfa.10
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2020 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ahzy6pQw/atNd37wto5420lAYtl9jHhEIzBJp0MwQiY=;
        b=MxOWolL4S0R/YpfXxj0Bwac85NuuLBnpRfbiS6TGZzNyu+nsWW2GarYviSd4gDm3Fq
         /EJPgrMiSFPbBJdXMeZKRuBm4TKxZrpvao+lvWrM93Wji42G6vnS8wZxFj/FT66Bj9sa
         tNxIm2P7rDYrKrKMTJfpvbo2cRSWvKUksqesAriOUp7jzq3d5Oh9oXy0D5yl9TBBSGua
         536MOtpWDCDiLl+6Y1vU6nvF/GZKeDPT08Jkh/903DdTAqeoV//glMcY4g+3XiQWuMbk
         hwmlVuWUBfFN7ui+3mThmImsloX3fpw/0RbfwmapMRHHg8X0ny3eUtMcOlZKV5jztJ97
         diCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ahzy6pQw/atNd37wto5420lAYtl9jHhEIzBJp0MwQiY=;
        b=Sa9fmlPXjUs1aFzZWofy+ExgRDVR03Qw5o9Hn+u5dle/l0Mcc/5sdAtT/kdZb9pJ9K
         lI2Iv5KcE0IxP4nodozKthHjSeKV6WVSqZhRSbyPfW6e/+Zk5sf/seUs6U4wBUBpVMjD
         Dp7eQC5n8//ZvWWmkvzobDAyCbRn7Abq/h5eZeN4KhgO8EqpHOU6xOV+x0FotUerMvto
         QrnenUwjKmOqNXR9ZzGOB6WujEfg/3b7UqCRm8GCG1g/SmVRQMhPohOCMixPk9kLTaVG
         TC5PSOV+dokyu7wRQosrbi+XLo+aK0APpFlu9vg+ZoxdHPPQi+PdNX7TGd0opLuz4k6R
         ck+g==
X-Gm-Message-State: ANhLgQ1a+ZmXaUSWB8qHmP6hF8U9/7VsxvgmxyJDGeKArQGFUb/b9uh5
        srbA7m7VNsQSe8OQ70V1O5cbdYuQz2E=
X-Google-Smtp-Source: ADFU+vvwM+Q6PdGqRDHR50Jtku4fM+WhIokt2aWtzVF9H3czA+fIBIY3DaNmRMunFH5zrpAFtyHQ5A==
X-Received: by 2002:a63:b905:: with SMTP id z5mr3258887pge.402.1585389352974;
        Sat, 28 Mar 2020 02:55:52 -0700 (PDT)
Received: from SARKAR ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id fa16sm5361718pjb.35.2020.03.28.02.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 02:55:52 -0700 (PDT)
Message-ID: <5e7f1f28.1c69fb81.33271.73d7@mx.google.com>
X-Google-Original-Message-ID: <20200328095549.GA8353@rohitsarkar5398@gmail.com>
Date:   Sat, 28 Mar 2020 15:25:49 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [GSOC] Choosing a component
References: <5e7cce84.1c69fb81.433c4.751d@mx.google.com>
 <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,
On Thu, Mar 26, 2020 at 05:13:24PM +0000, Bogdan, Dragos wrote:
> The IIO community can also suggest an Analog Devices component. 😊
> 
> Rohit, anyway, since the student application period ends soon, you can just think of one component type (e.g., ADC, DAC, etc.), create your plan accordingly and submit your proposal.
After doing a search through ADI's website, I chose the accelerometers
ADXL35x series (ADXL355[1] and ADXL357[2]) as a component that I could
write a driver for, having verified that there are no preexisting drivers
for the same.  Hope this is a decent choice. 

[1]: https://www.analog.com/en/products/adxl355.html
[2]: https://www.analog.com/en/products/adxl357.html
> Thanks,
> Dragos
> 
Thanks,
Rohit
