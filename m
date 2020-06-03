Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C173E1ECE5C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 13:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFCL3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 07:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCL3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 07:29:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC46C08C5C0;
        Wed,  3 Jun 2020 04:29:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so726178plr.4;
        Wed, 03 Jun 2020 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYDjEnMgktBuo6DQ1R8FXp/4FpW7wh5KhHgaA/MCrC0=;
        b=kiYRKNXTleel/idLEGZwK9UEaeJLEnR5m/VKB1rPaL47Lyah3lhtvoJ6Fbo/6xwr6r
         aj6DJ1QrVIRXuz9eLzn+aqmIcvrk4Z1aUYmjJDY20gZ6JltKfzQmAH5/t8ALSfzsbITc
         j+wY1PnYh+SZDsUCADDL4giBHXvWvdKee6dPnom0a4kuRLpKjR129MVb1S4EAMMfb06z
         fklytk5YoIBI7Bw6zjTeGqgHxTZBNhElpM6k9BZXqJvfVUaBEgA/TcyiUS/Moyvkz/6o
         s87fCtXg3kgAVI5q2EW0bUHS9m9YNzKK2N2icdzmZPwNNFSr4yF1FD1C9CppIpwDXqke
         m8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYDjEnMgktBuo6DQ1R8FXp/4FpW7wh5KhHgaA/MCrC0=;
        b=uoeSL0Yg67Iq1hql6rlUF6ESUEmHiceDKhwTtB1NNXmNGY3EuZp+BaDZMtgerhqXGL
         wRSgnzkJAfr0lI7CGEmzDeZgPFhff3usY/HkK+hzKSwYIPKDvhRKDTLTY6de9pKgSHex
         NXT38qJV9n0hm16in8JtZsGD5oFk+pIvzJ9oGObvZchS1S0xR+iFWrGP7xGoqA4PrhS7
         qzN+ylr1W2vxyxnNg+Ggc0IakQP4GUGJ/wBdZ7meAHVrIZVpfR8oY2+eDtDz0uDkBd/T
         6Atppxk8OwQvgBAodETuklmTRhfQ5/r9Vp3t0e23hD3AqL8alW1PrAskIlWWqaWoX3LX
         HlYQ==
X-Gm-Message-State: AOAM531OgWSHvej0V2URVM/p/fg5gQybjohFkeba+zDLkgGO+1Ss8mY7
        63ykOlCH3aDVX/pPTr0MaKnolnjM+QFSRNiyarg=
X-Google-Smtp-Source: ABdhPJwdso2nwPBvupIiAPgeIIBx0RbV4afBtdZXGJS6P6Gf51Z77H3U4cd6KGmw0Vzf1gImBRVZTGkAQRoBzZweINg=
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr29919248plt.18.1591183788151;
 Wed, 03 Jun 2020 04:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200603084441.33952-1-tomasz.duszynski@octakon.com> <20200603084441.33952-3-tomasz.duszynski@octakon.com>
In-Reply-To: <20200603084441.33952-3-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Jun 2020 14:29:36 +0300
Message-ID: <CAHp75VfF2KXS8NtPGqCRm3SA_pxz5-XmSSu7b_ytRP6TjaE5xw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: chemical: scd30: add I2C interface driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 3, 2020 at 11:47 AM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Add I2C interface driver for the SCD30 sensor.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  MAINTAINERS                      |   1 +
>  drivers/iio/chemical/Kconfig     |  11 +++
>  drivers/iio/chemical/Makefile    |   1 +
>  drivers/iio/chemical/scd30_i2c.c | 139 +++++++++++++++++++++++++++++++
>  4 files changed, 152 insertions(+)
>  create mode 100644 drivers/iio/chemical/scd30_i2c.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41a509cca6f1..13aed3473b7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15142,6 +15142,7 @@ M:      Tomasz Duszynski <tomasz.duszynski@octakon.com>
>  S:     Maintained
>  F:     drivers/iio/chemical/scd30.h
>  F:     drivers/iio/chemical/scd30_core.c
> +F:     drivers/iio/chemical/scd30_i2c.c
>
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:     Tomasz Duszynski <tduszyns@gmail.com>
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 99e852b67e55..970d34888c2e 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -96,6 +96,17 @@ config SCD30_CORE
>           To compile this driver as a module, choose M here: the module will
>           be called scd30_core.
>
> +config SCD30_I2C
> +       tristate "SCD30 carbon dioxide sensor I2C driver"
> +       depends on SCD30_CORE && I2C
> +       select CRC8
> +       help
> +         Say Y here to build support for the Sensirion SCD30 I2C interface
> +         driver.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called scd30_i2c.
> +
>  config SENSIRION_SGP30
>         tristate "Sensirion SGPxx gas sensors"
>         depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index c9804b041ecd..0966ca34e34b 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_CCS811)          += ccs811.o
>  obj-$(CONFIG_IAQCORE)          += ams-iaq-core.o
>  obj-$(CONFIG_PMS7003) += pms7003.o
>  obj-$(CONFIG_SCD30_CORE) += scd30_core.o
> +obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>  obj-$(CONFIG_SENSIRION_SGP30)  += sgp30.o
>  obj-$(CONFIG_SPS30) += sps30.o
>  obj-$(CONFIG_VZ89X)            += vz89x.o
> diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
> new file mode 100644
> index 000000000000..875892a070ee
> --- /dev/null
> +++ b/drivers/iio/chemical/scd30_i2c.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sensirion SCD30 carbon dioxide sensor i2c driver
> + *
> + * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
> + *
> + * I2C slave address: 0x61
> + */
> +#include <linux/crc8.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <asm/unaligned.h>
> +
> +#include "scd30.h"
> +
> +#define SCD30_I2C_MAX_BUF_SIZE 18
> +#define SCD30_I2C_CRC8_POLYNOMIAL 0x31
> +
> +static u16 scd30_i2c_cmd_lookup_tbl[] = {
> +       [CMD_START_MEAS] = 0x0010,
> +       [CMD_STOP_MEAS] = 0x0104,
> +       [CMD_MEAS_INTERVAL] = 0x4600,
> +       [CMD_MEAS_READY] = 0x0202,
> +       [CMD_READ_MEAS] = 0x0300,
> +       [CMD_ASC] = 0x5306,
> +       [CMD_FRC] = 0x5204,
> +       [CMD_TEMP_OFFSET] = 0x5403,
> +       [CMD_FW_VERSION] = 0xd100,
> +       [CMD_RESET] = 0xd304,
> +};
> +
> +DECLARE_CRC8_TABLE(scd30_i2c_crc8_tbl);
> +
> +static int scd30_i2c_xfer(struct scd30_state *state, char *txbuf, int txsize,
> +                         char *rxbuf, int rxsize)
> +{
> +       struct i2c_client *client = to_i2c_client(state->dev);
> +       int ret;
> +
> +       /*
> +        * repeated start is not supported hence instead of sending two i2c
> +        * messages in a row we send one by one
> +        */
> +       ret = i2c_master_send(client, txbuf, txsize);
> +       if (ret < 0)
> +               return ret;
> +       if (ret != txsize)
> +               return -EIO;
> +
> +       if (!rxbuf)
> +               return 0;
> +
> +       ret = i2c_master_recv(client, rxbuf, rxsize);
> +       if (ret < 0)
> +               return ret;
> +       if (ret != rxsize)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd, u16 arg,
> +                            void *response, int size)
> +{
> +       char buf[SCD30_I2C_MAX_BUF_SIZE];
> +       char *rsp = response;
> +       int i, ret;
> +       char crc;
> +
> +       put_unaligned_be16(scd30_i2c_cmd_lookup_tbl[cmd], buf);
> +       i = 2;
> +
> +       if (rsp) {
> +               /* each two bytes are followed by a crc8 */
> +               size += size / 2;
> +       } else {
> +               put_unaligned_be16(arg, buf + i);
> +               crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
> +               i += 2;
> +               buf[i] = crc;
> +               i += 1;
> +
> +               /* commands below don't take an argument */
> +               if ((cmd == CMD_STOP_MEAS) || (cmd == CMD_RESET))
> +                       i -= 3;
> +       }
> +
> +       ret = scd30_i2c_xfer(state, buf, i, buf, size);
> +       if (ret)
> +               return ret;
> +
> +       /* validate received data and strip off crc bytes */
> +       for (i = 0; i < size; i += 3) {
> +               crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
> +               if (crc != buf[i + 2]) {
> +                       dev_err(state->dev, "data integrity check failed\n");
> +                       return -EIO;
> +               }
> +
> +               *rsp++ = buf[i];
> +               *rsp++ = buf[i + 1];
> +       }
> +
> +       return 0;
> +}
> +
> +static int scd30_i2c_probe(struct i2c_client *client)
> +{
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +               return -EOPNOTSUPP;
> +
> +       crc8_populate_msb(scd30_i2c_crc8_tbl, SCD30_I2C_CRC8_POLYNOMIAL);
> +
> +       return scd30_probe(&client->dev, client->irq, client->name, NULL, scd30_i2c_command);
> +}
> +
> +static const struct of_device_id scd30_i2c_of_match[] = {
> +       { .compatible = "sensirion,scd30" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, scd30_i2c_of_match);
> +
> +static struct i2c_driver scd30_i2c_driver = {
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .of_match_table = scd30_i2c_of_match,
> +               .pm = &scd30_pm_ops,
> +       },
> +       .probe_new = scd30_i2c_probe,
> +};
> +module_i2c_driver(scd30_i2c_driver);
> +
> +MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
> +MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor i2c driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
