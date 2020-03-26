Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78307194982
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 21:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCZUrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 16:47:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40089 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZUrc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 16:47:32 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so2901490pjb.5
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2020 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18qaJ/K1xLzxfYE+2MLMBDCfeeYx1j0I5r8pQB6UlAY=;
        b=N/LhYzKV3gF3XhLOvoDDMMQkzb0os5rPMWx9cVgI2JfoQ6+KIUZ/Jsra4+ZYwiM80a
         QcQwnFLrEBTTc5idEKOypjsNlyNHy7V1TQzqKd4PEjZL+/oVrImz+l9y6u89NdggG1pc
         jIVGBErKDF/V1v4vxog75XU4yIACHpJSPZxZRctpLGettg5C6ojhmlTLglkCWAq6YYQl
         0I06tKb20roDTETtdLJqLJl0rf/5NBFZG5O0exGdtdlVbwryqg1vKYfVN6/Z6mlTZAry
         +LhJ2t3bscYwKoyPNpgjmiZjDVYIzR1OQ+alKoCYA45I8KyAHS/eEfeh2u1eHhs6QuC0
         j+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18qaJ/K1xLzxfYE+2MLMBDCfeeYx1j0I5r8pQB6UlAY=;
        b=XfQDcT3lIQmArJ08s2TUobWVUoQWIuN8JDX2OTnsEvx07aohrMbyBNbsG8eJ+MfIJM
         lVMbMWTwCJe9fschwxe7zb8OpEfXa7BOhhAq6R+xcZXY8rHa5TSV34nzbAErYdGV7Lz+
         UGdcvxtlCT1Q29LGuCj2Nya1k93oS55PCb1s5d5mhFBOmo708UtLnlfYGGLdMDeuDvVV
         BP1VV2kzvU9bnMbIUqDy1K6Cg/exrg6WmOQUiRw5OdAN5F/7dgePIyACINGUXVXBzE5S
         c32ZjGFli/oNDRV0cODuXrN7Y3t8r/javwwQ9BfLNGYS4i7OmquqUc1KsLlpngo+XD0J
         Lsig==
X-Gm-Message-State: ANhLgQ2qVrbxmG3fwGY1KUKskc+s5zRhTGUufpcQx7koapRi5HCcEdM7
        Mfj1fy33rtQskazlUEJnftiL0Y7pI34=
X-Google-Smtp-Source: ADFU+vtMHlesK1sPI5LMknzQkcqE3ojZgA0i6mzd8SbhLc5f0P6A+q3GjdamIRyucv/xqJC7Hie+vQ==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr10279978plr.84.1585255650404;
        Thu, 26 Mar 2020 13:47:30 -0700 (PDT)
Received: from SARKAR ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id 8sm1455780pfy.130.2020.03.26.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:47:29 -0700 (PDT)
Message-ID: <5e7d14e1.1c69fb81.ea538.41c0@mx.google.com>
X-Google-Original-Message-ID: <20200326204726.GA8860@rohitsarkar5398@gmail.com>
Date:   Fri, 27 Mar 2020 02:17:26 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [GSOC] Choosing a component
References: <5e7cce84.1c69fb81.433c4.751d@mx.google.com>
 <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
 <CAHp75VcxqoSiKiCfsq43_uwQHg6ptDWozTYkwcdX99pBiZT42Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcxqoSiKiCfsq43_uwQHg6ptDWozTYkwcdX99pBiZT42Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 26, 2020 at 10:44:34PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 26, 2020 at 7:14 PM Bogdan, Dragos <Dragos.Bogdan@analog.com> wrote:
> >
> > The IIO community can also suggest an Analog Devices component.
> 
> Last month on StackOverflow shows a lot of proposals :-)
> Just go with `i2c` tag and see what people are trying to enable (some
> sensors have been mentioned several times in different QnA). Also
> getting rid of MRAA/UPM is a good idea (moving them to libiio /
> libgpiod and moving sensor drivers to kernel).
> On top of that there are (plenty I think) projects on GitHub regarding
> drivers in user space which, in my opinion, should be rather in
> kernel.
> 
> Just my two cents.

Thanks Andy!
This helps a lot.
> > Rohit, anyway, since the student application period ends soon, you can just think of one component type (e.g., ADC, DAC, etc.), create your plan accordingly and submit your proposal.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
