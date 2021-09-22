Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7665E413F55
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 04:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhIVCTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 22:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhIVCTo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 22:19:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C40C061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Sep 2021 19:18:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so5635438lfv.4
        for <linux-iio@vger.kernel.org>; Tue, 21 Sep 2021 19:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LBOruX2eR+7jKvauM9hlcjfuarnMAn6pU6m++oNSb8U=;
        b=SsyJ2ECclE6NdhcOjZbcgEnX4q1ukfwBn9f5NinLZnR2aD/srYBY01kObiengWoLUo
         ICYh7i9nA8AH/NVAoYnZ7Tx8X5tAHVZRGM+VmtyWx+Jqt9ppppKhQxuiqn6EBThPDTlj
         GzqmOv1XJ4lA9jQESPRaH4Lxzh+XEKPsAeYbl82/Ir5A8mN06v69hRmmiY9q/uYC9y+f
         WzR3N12EN8UXgCb2igOXe7sg9o4zOdQVBMbhXqVPudRGLM/z+TRQ8J7ALthFHyX7iN+Q
         Wg0jF4YvLphCGMv1gQUlbrhPvRK94RNsG5toyunQp4lmB7E5oG+26MthKN91V2NolYJ7
         EeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LBOruX2eR+7jKvauM9hlcjfuarnMAn6pU6m++oNSb8U=;
        b=UZbLEd6uSCWt6Bhgw4LXHtcfvACa1j20gNKFKDFVHyYePoXS1uOK2IEHcS3s/h7VQ2
         EAW/ou/k0kDr1v/yevmsKfIEtGdZbxo+KVtKK0C//90RmeuCWGunQ3QTd1fo5j3sOpAF
         2PLNRflvr66LGzrCXypeLc7QmgInV16HWR8VrkCEvh6ulmPgNy1gUhLnWJ9i6Ru/iIa4
         gl/J5kRsc+T/89j4Uc6RrZ58c7ZjOsQi2kB0f7M8pwbV9BwjH692+4OTQ53bT7UOsic5
         P25w6+79EE78dgm9xc3RqiXcIpiMwgZpvPg9NB4IHztDwqvfxhLy4tps4QwRvWX+Qz02
         67RQ==
X-Gm-Message-State: AOAM533t+4T0eZiBPIJvBQoen2IImZLVR+wLsmQHHIa5m6hq7WBBVdoa
        1Fd65D4g/wVmpSgstzzXGGhJJkzFrHHKAv9E5a2AudfLnic=
X-Google-Smtp-Source: ABdhPJwUoizOr+m8BB4a5GdXFbPtVS1OadAo1cgoMoozwckSvjDFwlpM8b4gBhVbfKyzotvxk/OlEgo7e5OgQMit3mY=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr25486027lfq.113.1632277093913;
 Tue, 21 Sep 2021 19:18:13 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 21 Sep 2021 23:18:02 -0300
Message-ID: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
Subject: Reading ADC that comes from a multiplexer
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

I have a SN74LV4051 multiplexer that is controlled by 3 GPIOs and I
described like this in DT:

adcmux: mux-controller {
       compatible = "gpio-mux";
       #mux-control-cells = <0>;
       mux-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>,
                           <&gpio3 30 GPIO_ACTIVE_HIGH>,
                          <&gpio3 26 GPIO_ACTIVE_HIGH>;
};

adc-mux {
       compatible = "io-channel-mux";
       io-channels = <&adc 4>;
       io-channel-names = "parent";
       mux-controls = <&adcmux>;
       channels = "chan0", "chan1", "chan2", "chan3",
                         "chan4", "chan5", "chan6", "chan7";
};

/sys/class/mux/muxchip0/ is created:

# ls /sys/class/mux/muxchip0/
device  of_node  power  subsystem  uevent

Sorry for the trivial question, but I haven't found any examples.

What is the userspace command if I want to expose "chan3" to be read
by the ADC 4 channel?

Thanks,

Fabio Estevam
