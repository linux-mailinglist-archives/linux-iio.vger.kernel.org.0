Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FB194963
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgCZUos (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 16:44:48 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:40403 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgCZUos (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 16:44:48 -0400
Received: by mail-pf1-f174.google.com with SMTP id c20so837113pfi.7
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2020 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl5FJAYcl7zFRoYAD9e2zORoZEFECN1v/eHFZS+m3tQ=;
        b=EXf1Yh9rBvulxfOR9Xei225j1LNoZjJlp6l1NFMx7cpvS9twSnh18uDNC8LFNZdOja
         sWHLNWC13f7f8Dh8KpVr+wW1TaC3qrjFWPQd+NvRznJ0yd86RVOXxZb2rnIpIN1muDX5
         pf1M1UNOMIwLdMWuAXa2WXgRMlPQM5ZA+bz422lrGYfJ2FKtFCPcgdBlUGzqCsXxWRju
         a9w1fQrOHNrcgD0ItR4QCIy3du9yvcxFn0+8aMjv0mmbsUy1VSKVS4E1fi3qO4bcstFP
         gRnZRlffcOuS5+TotINmiCS38odWUx9F52NY2cFhpcNqFz01qJW9Z1T5rHk/gJvrdqQ+
         eTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl5FJAYcl7zFRoYAD9e2zORoZEFECN1v/eHFZS+m3tQ=;
        b=Fg22lgNK5cSWO0LqOSpeWsjqHJKYiIkQEpE9RBV4N3t0ohu9w9ftSpE3WSOyfyXmFU
         6SaCAi9iDcwY0E8bON/wdMteLStvZE/bhabQ327Qwlqn4FddnVOqQ5swgMGqN5NoSQdb
         3P4MiGaS4lrU41Mfvjd3wf5xGrFw/PPtzCoUs2JyY6GPQssp+YduH01d5YPhpn5gth+D
         PrWahsS4XcignaZjqv5Smt24xRZ8OKy5A++35IaKZvRTB6dGLXFwK+5OlPf9VFINFKEu
         MdEh2UZp7mALi932HB2ps0uA9DNqRt2bcaANyaJmDLSZ3msKT6NC/0vrohy2kPspO5Gp
         00SQ==
X-Gm-Message-State: ANhLgQ2954yR6ggVb9BCUuIdk8sWDa2zumWxJGgmSzOEaFgkK1S/5L9u
        cnp8FR1DQkGJ/439ImXaDkkK6qQmBt7F7c/j4wgSxsCKW6Q=
X-Google-Smtp-Source: ADFU+vszcQKNZWOQIFeWq79tR8nI5/MQu4+n6HwjuaCOCqcbtrTHdNizoX39vcsQTA+g+t0tgFzQKRzslsX+m0NGyDo=
X-Received: by 2002:a63:798a:: with SMTP id u132mr10830350pgc.203.1585255486592;
 Thu, 26 Mar 2020 13:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <5e7cce84.1c69fb81.433c4.751d@mx.google.com> <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Mar 2020 22:44:34 +0200
Message-ID: <CAHp75VcxqoSiKiCfsq43_uwQHg6ptDWozTYkwcdX99pBiZT42Q@mail.gmail.com>
Subject: Re: [GSOC] Choosing a component
To:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 26, 2020 at 7:14 PM Bogdan, Dragos <Dragos.Bogdan@analog.com> wrote:
>
> The IIO community can also suggest an Analog Devices component.

Last month on StackOverflow shows a lot of proposals :-)
Just go with `i2c` tag and see what people are trying to enable (some
sensors have been mentioned several times in different QnA). Also
getting rid of MRAA/UPM is a good idea (moving them to libiio /
libgpiod and moving sensor drivers to kernel).
On top of that there are (plenty I think) projects on GitHub regarding
drivers in user space which, in my opinion, should be rather in
kernel.

Just my two cents.

> Rohit, anyway, since the student application period ends soon, you can just think of one component type (e.g., ADC, DAC, etc.), create your plan accordingly and submit your proposal.


-- 
With Best Regards,
Andy Shevchenko
