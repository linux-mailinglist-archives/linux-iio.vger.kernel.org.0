Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884C91A817A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440249AbgDNPJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440317AbgDNPJC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 11:09:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4ACC061A0C;
        Tue, 14 Apr 2020 08:09:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so27508pfc.12;
        Tue, 14 Apr 2020 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIwIisg8wJsKulzHMel4nnap62IsdUq5I7BD8EdMy3U=;
        b=P6sHGcFsX1qm5pPBVeNB8LSBcEJG8cqvJ/iXSAAlTRjJmNwGQlzdBYyGlDGi5y2soU
         NxQqLtXnCKnYU92WMkjzF8j40JGiyiOM7CEH/QkTX9p7nf+rG7XXIar2rYTSofk0cjzt
         CfQuWMXqBhUh84K95BlmyeNJNtElrONAcreildOOnByS3pOd9oNstYX01mELuBZ5IX5j
         28ummg1turkUdKROs6ZKIgp7SJH5gDnTZ6fzJlMEPC2g9UnbuBPBQCB5u37vdjctfhxL
         mLwj3UmKDHrvJofVKg7y5QQGdp5ZiW5qAgsEtX5YdF5BUJzpZKPFqbn6aBludu3y73h4
         Qrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIwIisg8wJsKulzHMel4nnap62IsdUq5I7BD8EdMy3U=;
        b=QZzvLUIlEqDV1kTjmREUhIRM3aSvZw+LyDMjNcUPUfEHzPTQbYMhYIt2EHqyqJnhUK
         IEV4fdeqIzU0ZfpF46bD6fET2eGaG4eJHtQMlF4b1AOy6qbsBTi7iWaDJn7QiuQpOf9e
         8AbzxqduOL1w2k60SU+PQqNA3kUQy2HVHBh0YoQN9JZ+IENDTHhV5YDLx6fIcqG7dX8t
         BzK7+D7M0sY9CSynD9OEkGiYEnzuVlN47znXSUzexGrEoWyg/sQUy0swdXtCcx2ALLTA
         PWMQQU2YBSroqKAfxoG9zF+B0y48rSZs/jooEeXqSnfX5lO1SYpzmkAafhsMertMpMqm
         pQXA==
X-Gm-Message-State: AGi0PuY/7i26CWXD5nBm621xLECHXHlTAzBCbhczfPx9SjACD928LkNv
        g8LRjdAAg0GVKwjt2ZM9WPJ8HRa+XWG8dNHHLMBWD7+QMlY=
X-Google-Smtp-Source: APiQypIV3Zd98XVLtAsSdItRS2H+IZAJWUv+z9c5WVBVR9hPzW7VmKVLVj0gbXBqyItcafrn5j3EEUKAUw2MVwvbnpo=
X-Received: by 2002:a63:5511:: with SMTP id j17mr6514062pgb.4.1586876941742;
 Tue, 14 Apr 2020 08:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200413164402.v9.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
 <20200413164402.v9.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
In-Reply-To: <20200413164402.v9.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 18:08:54 +0300
Message-ID: <CAHp75Vfe3HAdKFbkXKrwVCnp=oziPY5GDrHTYJWPTW7OOX3LwQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 4:43 PM Daniel Campello <campello@chromium.org> wrote:
>
> Add SEMTECH SX9310/9311 driver.
>
> The device has the following entry points:
>
> Usual frequency:
> - sampling_frequency
> - sampling_frequency_available
>
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_comb_raw
> and associated events in events/
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
> Changes in v9:
>   - Updated Copyright
>   - Updated macro definitions
>   - Simplified return condition checks
>   - Removed ACPI and of table macros

Thank you for an update.
It seems you missed few comments from previous round.

-- 
With Best Regards,
Andy Shevchenko
