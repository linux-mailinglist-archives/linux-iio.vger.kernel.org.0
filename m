Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2A34A4E9
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhCZJvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCZJvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 05:51:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E4C0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 02:51:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx7so5561889edb.12
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wZPpf9llPyuTQAfH2IdoRQHFkEp599p5e0afGH+gDpM=;
        b=WGl0zGHug3WDu1yHqdYVz2+yt6FgWgleIWxvBgCqaAh4/9sCIaiC5UlPMmBlxvnzTw
         hj1KLnF8uajofzjlI2YGLoMu0oDK5Dzt0xXUDObAjZGQU1/WVfbXXPV1Qhk+H66/u2BP
         Hzi9cplij4ElAsdfhLLm/LktZmZp6KTZd1B2CV6U7IoyFNH4jQuvzWolScB3H9k8AF/R
         Y/Wcs78BpHM+jUB4wUm+h2NOFEbaClBhmPkqQvhwxXvCTaP3Ff1cqCTQ3zbaPQj/+RY+
         6gJfNUk6J6z1BcMtDsDMSk4lslCtTs8nWgpnB12xdvJiHn384/qAo20D9TKl6OFDTLoO
         ISVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wZPpf9llPyuTQAfH2IdoRQHFkEp599p5e0afGH+gDpM=;
        b=UeENfccXFOENqzRlxa2jgjoP3BcdDpWHlSA2NHlUdwIWEOefybkNXzkXhsuQFtF3qk
         IPSv0Dw54yuIFfWs1TFh0IguYxd42vHoxAW04W67EKkGTEeHxLkfvUqhv0smzNkWoayz
         IXnlST8nrQubWKY1IbZLcqYq4w3MVc+jS8HYcdp8DImZ9vkmAIvPYCQZaEFo359VjSNh
         Gm5YG5XFYj/9OS4VxiwOCf6WcnJfpngfiG73MA78Mq8Xa2JD+Mk1AlW8nmdYOv0P8FOl
         HwuAjFPfsqnlXM7huDKjnBNJ96msc5ipo06GzRdxvxRqfP/FTXD8hP9JTJg0FIJud8Vb
         Huwg==
X-Gm-Message-State: AOAM5323OF5WHy/SKFDCCl/zOcNTBxL3BFU83WwLr0YyrYKV2hhGGbuq
        bDKKzbwjQi3CIGZLH28T+L27I7VTsuU6xGMeyPax56+Fot9j6A==
X-Google-Smtp-Source: ABdhPJxwd+LgoQ6fLbDiI6GU1R5Y74LJ8eKn6oxhwO0e8rDavIhh6SYMa0xa/taOulT8NmeLY66VBBHBFk4dVhG4fv0=
X-Received: by 2002:aa7:db15:: with SMTP id t21mr13919805eds.145.1616752263277;
 Fri, 26 Mar 2021 02:51:03 -0700 (PDT)
MIME-Version: 1.0
From:   Mugil Raj <dmugil2000@gmail.com>
Date:   Fri, 26 Mar 2021 15:20:52 +0530
Message-ID: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
Subject: [RFC] GSoC'21 IIO project: Mugil
To:     linux-iio <linux-iio@vger.kernel.org>, dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello All,

[Dragos here you have a quick intro about me if you want,
https://lore.kernel.org/linux-iio/CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com/]

For GSoC'21 IIO project I would like to choose  AD4695/AD4696 device
for implementing the driver.
I referred Analog Device, Inc.'s page that lists all drivers and
their kernel tree, but there is no existence of any compatible drivers
for this component.

About AD4695:
- 16-Channel, 16-bit 500 kSPS SAR ADC
- "Recommended for New Designs" phase
- SPI digital output
- Datasheet in [1]
- Product overview in [2]

Is there any other factor I should consider before choosing a component
to make a driver for? Do I go ahead with AD4695  in my
proposal? If yes, are there any recommendations/suggestions you'd like
to provide for a beginner indulging in making a kernel driver for such a
component?

Thanks,
Mugil

[1] https://www.analog.com/media/en/technical-documentation/data-sheets/ad4695_4696.pdf
[2] https://www.analog.com/en/products/ad4695.html#product-overview
